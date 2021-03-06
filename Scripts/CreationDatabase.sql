 
CREATE DATABASE GLOBAL_BELLEZA
GO
USE [GLOBAL_BELLEZA]
GO
CREATE TABLE [dbo].[trabajador](
	[idtrabajador] [int] IDENTITY(1,1) NOT NULL,
	[nombre] [varchar](20) NOT NULL,
	[apellidos] [varchar](40) NOT NULL,
	[sexo] [char](10) NOT NULL,
	[Fecha_nac] [datetime] NOT NULL,
	[num_documento] [varchar](15) NOT NULL,
	[direccion] [varchar](100) NOT NULL,
	[telefono] [varchar](15) NOT NULL,
	[email] [varchar](50) NOT NULL,
	[StatusE] [bit] NOT NULL,
	[FechaAdiciona] [datetime] NULL,
	[FechaModifica] [datetime] NULL,
	[UsuarioAdiciona] [varchar](50) NULL,
	[UsuarioModifica] [varchar](50) NULL,
 CONSTRAINT [PK_trabajador] PRIMARY KEY CLUSTERED 
(
	[idtrabajador] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[wv_get_employees]    Script Date: 28/10/2018 16:22:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
	CREATE VIEW [dbo].[wv_get_employees]
	as
	
	 SELECT
	   [idtrabajador]  
      ,upper(apellidos+' '+nombre)[NombreCompleto]      
      ,[sexo]
      ,[Fecha_nac]
      ,[num_documento]
      ,[direccion]
      ,[telefono]
      ,[email]
      ,iif([StatusE]=1,'Activo','Inactivo')[Estado]
      ,[FechaAdiciona]
      ,[FechaModifica]
      ,[UsuarioAdiciona]
      ,[UsuarioModifica]
  FROM [dbventas].[dbo].[trabajador]
  where StatusE=1
GO
/****** Object:  Table [dbo].[cuentas_x_cobrar]    Script Date: 28/10/2018 16:22:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cuentas_x_cobrar](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[id_cliente] [int] NOT NULL,
	[fecha] [date] NOT NULL,
	[valor] [decimal](18, 2) NOT NULL,
	[pagado] [bit] NOT NULL,
	[usuario] [varchar](50) NOT NULL,
	[id_venta] [int] NOT NULL,
	[CantidadPagada] [decimal](18, 2) NULL,
	[MontoAdeudado] [decimal](9, 2) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[cliente]    Script Date: 28/10/2018 16:22:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cliente](
	[idcliente] [int] IDENTITY(1,1) NOT NULL,
	[nombre] [varchar](50) NOT NULL,
	[apellidos] [varchar](40) NULL,
	[sexo] [char](10) NULL,
	[fecha_nacimiento] [date] NULL,
	[tipo_documento] [varchar](20) NOT NULL,
	[num_documento] [varchar](15) NOT NULL,
	[direccion] [varchar](100) NULL,
	[telefono] [varchar](15) NULL,
	[email] [varchar](50) NULL,
	[statu] [bit] NULL,
	[CodigoCliente]  AS ((CONVERT([varchar],datepart(day,[fecha_nacimiento]))+'-0')+CONVERT([varchar],[idcliente])),
	[FechaAdiciona] [datetime] NULL,
	[FechaModifica] [datetime] NULL,
	[UsuarioAdiciona] [varchar](50) NULL,
	[UsuarioModifica] [varchar](50) NULL,
	[HostName] [varchar](200) NULL,
 CONSTRAINT [PK_cliente] PRIMARY KEY CLUSTERED 
(
	[idcliente] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[get_client_parameter]    Script Date: 28/10/2018 16:22:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

  CREATE view [dbo].[get_client_parameter]
  as  
  
  select 
  c.id
  ,c.[id_cliente]
  ,cl.CodigoCliente
  ,cl.num_documento 
  ,(cl.nombre +''+ cl.apellidos) NombreCompleto   
  ,[fecha]
  ,[valor]
  ,[pagado] 
    
  from [dbo].[cuentas_x_cobrar]c
  left join dbo.cliente cl

  on c.id_cliente=cl.idcliente

  where --cl.CodigoCliente='6-015'
         cl.statu=1
		and c.pagado=0
GO
/****** Object:  View [dbo].[VW_CLIENTES_LOAD]    Script Date: 28/10/2018 16:22:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE VIEW [dbo].[VW_CLIENTES_LOAD]

AS
SELECT [idcliente]
      ,CodigoCliente
      ,upper(apellidos+' '+nombre)[Nombre_Completo_Empleado]
      ,[Sexo]
      ,[fecha_nacimiento][Fecha Nacimiento]
      ,[tipo_documento][Tipo_de_Documento]
      ,[num_documento][Numero_Identificación]
      ,[direccion][Direccion]
      ,[telefono][Telefono]
      ,[email][Correo_electronico]
      --iif([statu]=0,'Inactivo','Activo')[Status]
	  --,statu
  FROM  [dbo].[cliente] where statu=1
GO
/****** Object:  Table [dbo].[Factura]    Script Date: 28/10/2018 16:22:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Factura](
	[id_factura] [int] IDENTITY(1,1) NOT NULL,
	[id_cliente] [int] NOT NULL,
	[nombre_trabajador] [varchar](100) NOT NULL,
	[tipo_pago] [varchar](50) NOT NULL,
	[fecha] [date] NOT NULL,
	[medio_pago] [varchar](50) NOT NULL,
	[id_venta] [int] NOT NULL,
	[id_trabajador] [int] NOT NULL,
	[cantidad_articulos] [int] NOT NULL,
	[subtotal] [decimal](18, 2) NOT NULL,
	[itbis] [decimal](9, 2) NOT NULL,
	[total] [decimal](18, 2) NOT NULL,
	[numero_factura] [varchar](100) NULL,
 CONSTRAINT [PK_Factura] PRIMARY KEY CLUSTERED 
(
	[id_factura] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[wv_get_cliente_deuda]    Script Date: 28/10/2018 16:22:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






CREATE view [dbo].[wv_get_cliente_deuda]

as

SELECT cc.id
       ,cc.id_cliente
	  ,c.num_documento
	  ,c.CodigoCliente
	  ,(c.nombre+' '+c.apellidos) as NombreCompleto
	  ,cc.fecha
	  ,cc.valor
	  ,cc.pagado
	  ,f.id_factura
	  FROM dbo.[cuentas_x_cobrar]cc 
inner join dbo.[cliente]c

on 

cc.id_cliente=c.idcliente

inner join  dbo.Factura f
on f.id_venta=cc.id_venta

where c.statu=1   and cc.pagado=0
and valor>0

 
GO
/****** Object:  Table [dbo].[USERS]    Script Date: 28/10/2018 16:22:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[USERS](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[Usuario] [varchar](50) NOT NULL,
	[Clave] [varchar](50) NOT NULL,
	[RolID] [int] NOT NULL,
	[Statud] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UsuarioTrabajador]    Script Date: 28/10/2018 16:22:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UsuarioTrabajador](
	[id] [int] NOT NULL,
	[id_trabajador] [int] NULL,
	[id_usuario] [int] NULL,
	[fecha_asignacion] [datetime] NULL,
	[fecha_deasinacion] [datetime] NULL,
	[status_assignacion] [bit] NULL,
	[usuarioAdiciona] [varchar](50) NULL,
	[usuarioModifica] [varchar](50) NULL,
	[fechaAdiciona] [datetime] NULL,
	[fechaModifica] [datetime] NULL,
 CONSTRAINT [PK_UsuarioTrabajador] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[wv_usuario_trabajador]    Script Date: 28/10/2018 16:22:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE view [dbo].[wv_usuario_trabajador]
as
select u.RolID,(t.nombre+' '+t.apellidos)[NombreCompleto],u.Clave,u.Usuario,t.idtrabajador 
from dbo.[UsuarioTrabajador]ut
  inner join 
dbo.[trabajador]t 

on t.idtrabajador=ut.id_trabajador
left join dbo.[USERS]u

on u.id=ut.id_usuario

where       
            u.Statud=1
         and   t.StatusE=1
		 and   ut.fecha_deasinacion is null
		and ut.status_assignacion=1

GO
/****** Object:  View [dbo].[ROL_USER]    Script Date: 28/10/2018 16:22:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[ROL_USER] 
AS
SELECT  RolID
FROM    dbo.USERS WHERE [Statud]=1
GO
/****** Object:  Table [dbo].[cotizacion]    Script Date: 28/10/2018 16:22:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cotizacion](
	[idcotizacion] [int] IDENTITY(1,1) NOT NULL,
	[idcliente] [int] NOT NULL,
	[idtrabajador] [int] NOT NULL,
	[cantidad] [int] NOT NULL,
	[subtotal] [decimal](18, 2) NOT NULL,
	[itbis] [decimal](9, 2) NOT NULL,
	[total] [decimal](18, 2) NOT NULL,
	[fecha] [date] NOT NULL,
	[estatus] [bit] NOT NULL,
 CONSTRAINT [PK_cotizacion] PRIMARY KEY CLUSTERED 
(
	[idcotizacion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[detalle_cotizacion_productos]    Script Date: 28/10/2018 16:22:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[detalle_cotizacion_productos](
	[id_cotizacion_producto] [int] IDENTITY(1,1) NOT NULL,
	[idcotizacion] [int] NOT NULL,
	[producto] [varchar](50) NOT NULL,
	[cantidad] [int] NOT NULL,
	[precioVenta] [decimal](18, 2) NOT NULL,
	[itbis] [decimal](9, 2) NOT NULL,
	[subtotal] [decimal](18, 2) NOT NULL,
	[total] [decimal](18, 2) NOT NULL,
 CONSTRAINT [PK_detalle_cotizacion_productos] PRIMARY KEY CLUSTERED 
(
	[id_cotizacion_producto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[VW_COTIZACIONES]    Script Date: 28/10/2018 16:22:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[VW_COTIZACIONES]
AS
SELECT        dbo.cotizacion.idcotizacion AS [No. Cotizacion], dbo.cliente.nombre + ' ' + dbo.cliente.apellidos AS Cliente, dbo.trabajador.nombre + ' ' + dbo.trabajador.apellidos AS Empleado, 
                        dbo.detalle_cotizacion_productos.producto AS Producto, dbo.detalle_cotizacion_productos.cantidad AS Cantidad, dbo.detalle_cotizacion_productos.precioVenta AS Precio, 
                        dbo.detalle_cotizacion_productos.itbis AS ITBIS, dbo.cotizacion.cantidad AS Articulos, dbo.cotizacion.subtotal AS [Sub-Total], dbo.cotizacion.itbis AS [Total ITBIS], dbo.cotizacion.total AS [Total Cotizado], 
                        dbo.cotizacion.fecha AS Fecha
FROM            dbo.detalle_cotizacion_productos INNER JOIN
                        dbo.cotizacion ON dbo.detalle_cotizacion_productos.idcotizacion = dbo.cotizacion.idcotizacion INNER JOIN
                        dbo.cliente ON dbo.cotizacion.idcliente = dbo.cliente.idcliente INNER JOIN
                        dbo.trabajador ON dbo.cotizacion.idtrabajador = dbo.trabajador.idtrabajador

GO
/****** Object:  Table [dbo].[articulo]    Script Date: 28/10/2018 16:22:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[articulo](
	[idarticulo] [int] IDENTITY(1,1) NOT NULL,
	[nombre] [varchar](50) NOT NULL,
	[idcategoria] [int] NOT NULL,
	[Codigo] [varchar](50) NULL,
	[Imag_Url] [varchar](250) NULL,
	[descripcion] [varchar](200) NULL,
	[precioVenta] [decimal](9, 2) NULL,
	[precioCompra] [decimal](9, 2) NULL,
	[cantidad] [decimal](9, 2) NULL,
	[estado] [bit] NULL,
	[idProveedor] [int] NOT NULL,
	[CodigoBarra]  AS (CONVERT([varchar],(upper(substring([nombre],(1),(4)))+'00000')+CONVERT([varchar],[idarticulo]))),
 CONSTRAINT [PK_articulo] PRIMARY KEY CLUSTERED 
(
	[idarticulo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[categoria]    Script Date: 28/10/2018 16:22:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[categoria](
	[idcategoria] [int] IDENTITY(1,1) NOT NULL,
	[nombre] [varchar](50) NOT NULL,
	[descripcion] [nchar](256) NULL,
 CONSTRAINT [PK_categoria] PRIMARY KEY CLUSTERED 
(
	[idcategoria] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Ciudad]    Script Date: 28/10/2018 16:22:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Ciudad](
	[CiudadID] [int] NOT NULL,
	[CiudadNombre] [char](35) NOT NULL,
	[PaisCodigo] [char](3) NOT NULL,
	[CiudadDistrito] [char](20) NOT NULL,
	[CiudadPoblacion] [int] NOT NULL,
	[id_pais] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[CiudadID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[cuentas_x_pagar]    Script Date: 28/10/2018 16:22:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cuentas_x_pagar](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[id_proveedor] [int] NOT NULL,
	[fecha] [datetime] NOT NULL,
	[valor] [decimal](18, 2) NOT NULL,
	[pagado] [bit] NOT NULL,
	[usuario] [varchar](50) NOT NULL,
 CONSTRAINT [PK_cuentas_x_pagar] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[detalle_ingreso]    Script Date: 28/10/2018 16:22:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[detalle_ingreso](
	[iddetalle_ingreso] [int] IDENTITY(1,1) NOT NULL,
	[idarticulo] [int] NOT NULL,
	[idingreso] [int] NOT NULL,
	[precio_compra] [decimal](9, 2) NOT NULL,
	[precio_venta] [decimal](9, 2) NOT NULL,
	[stock_inicial] [int] NOT NULL,
	[stock_actual] [int] NOT NULL,
	[fecha_produccion] [date] NOT NULL,
	[fecha_vencimiento] [date] NOT NULL,
 CONSTRAINT [PK_detalle_ingreso] PRIMARY KEY CLUSTERED 
(
	[iddetalle_ingreso] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[detalle_venta]    Script Date: 28/10/2018 16:22:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[detalle_venta](
	[iddetalle_venta] [int] IDENTITY(1,1) NOT NULL,
	[producto] [varchar](50) NULL,
	[idventa] [int] NOT NULL,
	[cantidad] [int] NOT NULL,
	[precio_venta] [money] NOT NULL,
	[descuento] [money] NOT NULL,
	[itbis] [decimal](9, 2) NULL,
	[sub_itbis]  AS ([cantidad]*[itbis]),
	[sub_total]  AS ([cantidad]*[precio_venta]),
 CONSTRAINT [PK_detalle_venta] PRIMARY KEY CLUSTERED 
(
	[iddetalle_venta] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ingreso]    Script Date: 28/10/2018 16:22:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ingreso](
	[idingreso] [int] IDENTITY(1,1) NOT NULL,
	[CodigBarra] [int] NULL,
	[idproveedor] [int] NOT NULL,
	[fecha] [date] NOT NULL,
	[tipo_comprobante] [varchar](20) NOT NULL,
	[igv] [decimal](9, 2) NOT NULL,
	[FechaAdiciona] [datetime] NOT NULL,
	[FechaModifica] [datetime] NULL,
	[UsuarioAdiciona] [varchar](50) NOT NULL,
	[UsuarioModifica] [varchar](50) NULL,
 CONSTRAINT [PK_ingreso] PRIMARY KEY CLUSTERED 
(
	[idingreso] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MovimientosPagosYcobranzas]    Script Date: 28/10/2018 16:22:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MovimientosPagosYcobranzas](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[DetalleMov] [varchar](50) NULL,
	[fechaPago] [datetime] NULL,
	[idFactura] [varchar](60) NULL,
	[cantidadPagada] [decimal](9, 2) NULL,
	[statud] [bit] NULL,
	[usuarioPago] [varchar](50) NULL,
	[id_cxc] [int] NULL,
	[id_cxp] [int] NULL,
 CONSTRAINT [PK__Movimien__3213E83F5BDAEDBE] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Ncf_Comprovante]    Script Date: 28/10/2018 16:22:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Ncf_Comprovante](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[Tipo_Comprovante_Fiscal] [varchar](50) NULL,
	[Number] [varchar](50) NULL,
	[estado] [bit] NULL,
 CONSTRAINT [PK_Ncf_Comprovante] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Pais]    Script Date: 28/10/2018 16:22:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Pais](
	[id_pais] [int] IDENTITY(1,1) NOT NULL,
	[PaisCodigo] [char](3) NOT NULL,
	[PaisNombre] [char](52) NOT NULL,
	[PaisContinente] [varchar](50) NOT NULL,
	[PaisRegion] [varchar](26) NOT NULL,
	[PaisArea] [float] NOT NULL,
	[PaisIndependencia] [smallint] NULL,
	[PaisPoblacion] [int] NOT NULL,
	[PaisExpectativaDeVida] [float] NULL,
	[PaisProductoInternoBruto] [float] NULL,
	[PaisProductoInternoBrutoAntiguo] [float] NULL,
	[PaisNombreLocal] [varchar](45) NOT NULL,
	[PaisGobierno] [varchar](45) NOT NULL,
	[PaisJefeDeEstado] [varchar](60) NULL,
	[PaisCapital] [int] NULL,
	[PaisCodigo2] [char](2) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id_pais] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[proveedor]    Script Date: 28/10/2018 16:22:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[proveedor](
	[idproveedor] [int] IDENTITY(1,1) NOT NULL,
	[razon_social] [varchar](150) NOT NULL,
	[NombreProveedor] [varchar](50) NOT NULL,
	[tipo_documento] [varchar](20) NOT NULL,
	[num_documento] [varchar](15) NOT NULL,
	[direccion] [nchar](100) NULL,
	[telefono] [varchar](10) NULL,
	[email] [varchar](50) NULL,
	[url] [varchar](100) NULL,
	[statu] [bit] NULL,
	[FechaAdiciona] [datetime] NULL,
	[FechaModifica] [datetime] NULL,
	[UsuarioAdiciona] [varchar](50) NULL,
	[UsuarioModifica] [varchar](50) NULL,
	[HostName] [varchar](200) NULL,
 CONSTRAINT [PK_proveedor] PRIMARY KEY CLUSTERED 
(
	[idproveedor] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ROLES]    Script Date: 28/10/2018 16:22:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ROLES](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](50) NOT NULL,
	[Grupo] [varchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[venta]    Script Date: 28/10/2018 16:22:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[venta](
	[idventa] [int] IDENTITY(1,1) NOT NULL,
	[idcliente] [int] NOT NULL,
	[idtrabajador] [int] NOT NULL,
	[fecha] [date] NOT NULL,
	[tipo_comprobante] [varchar](20) NOT NULL,
	[tipo_venta] [varchar](20) NOT NULL,
	[tipo_cliente] [varchar](20) NOT NULL,
	[itbis] [decimal](9, 2) NOT NULL,
	[total] [decimal](18, 2) NOT NULL,
	[subtotal] [decimal](18, 2) NOT NULL,
 CONSTRAINT [PK_venta] PRIMARY KEY CLUSTERED 
(
	[idventa] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[articulo] ADD  CONSTRAINT [DF__articulo__estado__3F466844]  DEFAULT ((0)) FOR [estado]
GO
ALTER TABLE [dbo].[Ciudad] ADD  DEFAULT ('') FOR [CiudadNombre]
GO
ALTER TABLE [dbo].[Ciudad] ADD  DEFAULT ('') FOR [PaisCodigo]
GO
ALTER TABLE [dbo].[Ciudad] ADD  DEFAULT ('') FOR [CiudadDistrito]
GO
ALTER TABLE [dbo].[Ciudad] ADD  DEFAULT ('0') FOR [CiudadPoblacion]
GO
ALTER TABLE [dbo].[cotizacion] ADD  CONSTRAINT [DF_cotizacion_estatus]  DEFAULT ((1)) FOR [estatus]
GO
ALTER TABLE [dbo].[cuentas_x_pagar] ADD  DEFAULT (getdate()) FOR [fecha]
GO
ALTER TABLE [dbo].[cuentas_x_pagar] ADD  DEFAULT ((0)) FOR [pagado]
GO
ALTER TABLE [dbo].[Factura] ADD  CONSTRAINT [DF_Factura_fecha]  DEFAULT (getdate()) FOR [fecha]
GO
ALTER TABLE [dbo].[Factura] ADD  CONSTRAINT [DF_Factura_numero_factura]  DEFAULT ('(''NFC''+CONVERT(varchar(50),(upper(substring([nombre_trabajador],(1),(4)))+''000000'')+CONVERT(varchar(10),[id_venta])))') FOR [numero_factura]
GO
ALTER TABLE [dbo].[Pais] ADD  DEFAULT ('') FOR [PaisCodigo]
GO
ALTER TABLE [dbo].[Pais] ADD  DEFAULT ('') FOR [PaisNombre]
GO
ALTER TABLE [dbo].[Pais] ADD  DEFAULT ('Asia') FOR [PaisContinente]
GO
ALTER TABLE [dbo].[Pais] ADD  DEFAULT ('') FOR [PaisRegion]
GO
ALTER TABLE [dbo].[Pais] ADD  DEFAULT ('0.00') FOR [PaisArea]
GO
ALTER TABLE [dbo].[Pais] ADD  DEFAULT (NULL) FOR [PaisIndependencia]
GO
ALTER TABLE [dbo].[Pais] ADD  DEFAULT ('0') FOR [PaisPoblacion]
GO
ALTER TABLE [dbo].[Pais] ADD  DEFAULT (NULL) FOR [PaisExpectativaDeVida]
GO
ALTER TABLE [dbo].[Pais] ADD  DEFAULT (NULL) FOR [PaisProductoInternoBruto]
GO
ALTER TABLE [dbo].[Pais] ADD  DEFAULT (NULL) FOR [PaisProductoInternoBrutoAntiguo]
GO
ALTER TABLE [dbo].[Pais] ADD  DEFAULT ('') FOR [PaisNombreLocal]
GO
ALTER TABLE [dbo].[Pais] ADD  DEFAULT ('') FOR [PaisGobierno]
GO
ALTER TABLE [dbo].[Pais] ADD  DEFAULT (NULL) FOR [PaisJefeDeEstado]
GO
ALTER TABLE [dbo].[Pais] ADD  DEFAULT (NULL) FOR [PaisCapital]
GO
ALTER TABLE [dbo].[Pais] ADD  DEFAULT ('') FOR [PaisCodigo2]
GO
ALTER TABLE [dbo].[USERS] ADD  DEFAULT ((0)) FOR [Statud]
GO
ALTER TABLE [dbo].[articulo]  WITH CHECK ADD  CONSTRAINT [FK_articulo_categoria] FOREIGN KEY([idcategoria])
REFERENCES [dbo].[categoria] ([idcategoria])
GO
ALTER TABLE [dbo].[articulo] CHECK CONSTRAINT [FK_articulo_categoria]
GO
ALTER TABLE [dbo].[cotizacion]  WITH CHECK ADD  CONSTRAINT [FK_cotizacion_cliente] FOREIGN KEY([idcliente])
REFERENCES [dbo].[cliente] ([idcliente])
GO
ALTER TABLE [dbo].[cotizacion] CHECK CONSTRAINT [FK_cotizacion_cliente]
GO
ALTER TABLE [dbo].[cotizacion]  WITH CHECK ADD  CONSTRAINT [FK_cotizacion_trabajador] FOREIGN KEY([idtrabajador])
REFERENCES [dbo].[trabajador] ([idtrabajador])
GO
ALTER TABLE [dbo].[cotizacion] CHECK CONSTRAINT [FK_cotizacion_trabajador]
GO
ALTER TABLE [dbo].[cuentas_x_pagar]  WITH CHECK ADD  CONSTRAINT [FK_cuentas_x_pagar_proveedor] FOREIGN KEY([id_proveedor])
REFERENCES [dbo].[proveedor] ([idproveedor])
GO
ALTER TABLE [dbo].[cuentas_x_pagar] CHECK CONSTRAINT [FK_cuentas_x_pagar_proveedor]
GO
ALTER TABLE [dbo].[detalle_cotizacion_productos]  WITH CHECK ADD  CONSTRAINT [FK_detalle_cotizacion_productos_cotizacion] FOREIGN KEY([idcotizacion])
REFERENCES [dbo].[cotizacion] ([idcotizacion])
GO
ALTER TABLE [dbo].[detalle_cotizacion_productos] CHECK CONSTRAINT [FK_detalle_cotizacion_productos_cotizacion]
GO
ALTER TABLE [dbo].[detalle_ingreso]  WITH CHECK ADD  CONSTRAINT [FK_detalle_ingreso_articulo] FOREIGN KEY([idarticulo])
REFERENCES [dbo].[articulo] ([idarticulo])
GO
ALTER TABLE [dbo].[detalle_ingreso] CHECK CONSTRAINT [FK_detalle_ingreso_articulo]
GO
ALTER TABLE [dbo].[detalle_ingreso]  WITH CHECK ADD  CONSTRAINT [FK_detalle_ingreso_detalle_ingreso] FOREIGN KEY([iddetalle_ingreso])
REFERENCES [dbo].[detalle_ingreso] ([iddetalle_ingreso])
GO
ALTER TABLE [dbo].[detalle_ingreso] CHECK CONSTRAINT [FK_detalle_ingreso_detalle_ingreso]
GO
ALTER TABLE [dbo].[detalle_venta]  WITH CHECK ADD  CONSTRAINT [FK_detalle_venta_venta] FOREIGN KEY([idventa])
REFERENCES [dbo].[venta] ([idventa])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[detalle_venta] CHECK CONSTRAINT [FK_detalle_venta_venta]
GO
ALTER TABLE [dbo].[Factura]  WITH CHECK ADD  CONSTRAINT [FK_Factura_cliente] FOREIGN KEY([id_cliente])
REFERENCES [dbo].[cliente] ([idcliente])
GO
ALTER TABLE [dbo].[Factura] CHECK CONSTRAINT [FK_Factura_cliente]
GO
ALTER TABLE [dbo].[Factura]  WITH CHECK ADD  CONSTRAINT [FK_Factura_trabajador] FOREIGN KEY([id_trabajador])
REFERENCES [dbo].[trabajador] ([idtrabajador])
GO
ALTER TABLE [dbo].[Factura] CHECK CONSTRAINT [FK_Factura_trabajador]
GO
ALTER TABLE [dbo].[Factura]  WITH CHECK ADD  CONSTRAINT [FK_Factura_venta] FOREIGN KEY([id_venta])
REFERENCES [dbo].[venta] ([idventa])
GO
ALTER TABLE [dbo].[Factura] CHECK CONSTRAINT [FK_Factura_venta]
GO
ALTER TABLE [dbo].[MovimientosPagosYcobranzas]  WITH CHECK ADD  CONSTRAINT [FK_MovimientosPagosYcobranzas_cuentas_x_pagar] FOREIGN KEY([id_cxp])
REFERENCES [dbo].[cuentas_x_pagar] ([id])
GO
ALTER TABLE [dbo].[MovimientosPagosYcobranzas] CHECK CONSTRAINT [FK_MovimientosPagosYcobranzas_cuentas_x_pagar]
GO
ALTER TABLE [dbo].[USERS]  WITH CHECK ADD  CONSTRAINT [FK_USERS_ROLES] FOREIGN KEY([RolID])
REFERENCES [dbo].[ROLES] ([id])
GO
ALTER TABLE [dbo].[USERS] CHECK CONSTRAINT [FK_USERS_ROLES]
GO
ALTER TABLE [dbo].[venta]  WITH CHECK ADD  CONSTRAINT [FK_venta_cliente] FOREIGN KEY([idcliente])
REFERENCES [dbo].[cliente] ([idcliente])
GO
ALTER TABLE [dbo].[venta] CHECK CONSTRAINT [FK_venta_cliente]
GO
ALTER TABLE [dbo].[venta]  WITH CHECK ADD  CONSTRAINT [FK_venta_trabajador] FOREIGN KEY([idtrabajador])
REFERENCES [dbo].[trabajador] ([idtrabajador])
GO
ALTER TABLE [dbo].[venta] CHECK CONSTRAINT [FK_venta_trabajador]
GO
/****** Object:  StoredProcedure [dbo].[FACTURA_A_IMPRIMIR]    Script Date: 28/10/2018 16:22:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[FACTURA_A_IMPRIMIR]
@id_factura int
AS
SELECT f.[id_factura] AS [Id Factura]
      ,(c.[nombre] + ' ' + c.[apellidos]) AS [Cliente]
      ,f.[nombre_trabajador] AS Empleado
      ,f.[tipo_pago] as [Tipo de Pago]
      ,f.[fecha] as [Fecha]
      ,f.[medio_pago] as [Medio de Pago]
      ,f.[cantidad_articulos] as [No. Articulos]
      ,f.[subtotal] as [Subtotal]
      ,f.[itbis] as ITBIS
      ,f.[total] as Total
      ,f.[numero_factura] as [No. Factura]
	  ,d.[producto] as Producto
	  ,d.[cantidad] as Cantidad
	  ,d.[precio_venta] as Precio
	  ,(CONVERT(VARCHAR(10),(d.[descuento] * 100))+'%') as [Descuento]
	  ,d.[itbis] as PITBIS
	  ,d.[sub_itbis] as [PSUBITBIS]
	  ,d.[sub_total] as [PSUBTOTAL]
  FROM [dbo].[Factura] as f 
  INNER JOIN cliente c on c.idcliente = f.id_cliente
  INNER JOIN detalle_venta d on d.idventa = f.id_venta
  WHERE f.id_factura = @id_factura

GO
/****** Object:  StoredProcedure [dbo].[FILL_DROP_DOWN]    Script Date: 28/10/2018 16:22:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 
 CREATE PROC [dbo].[FILL_DROP_DOWN] 
@Valor varchar(25)='Default' 
,@id int =0

as
 

if @Valor='Default'
	begin
		select id_Pais,PaisNombre,id_Pais[id],PaisNombre[Valor] from dbo.Pais  
		ORDER BY PaisNombre
	end
else if @Valor='Provincia'
	begin
	select CiudadID,CiudadNombre from dbo.ciudad where id_pais=@id
		ORDER BY CiudadNombre
	end

	else if @Valor='Municipio'
	begin
	select CiudadID,CiudadNombre from dbo.ciudad where CiudadID=@id
	end	

	else if @Valor='categoria'
	begin
	select idcategoria,nombre from dbo.categoria  
	end	
	 
	 else if @Valor='proveedor'
	begin
	select idproveedor,UPPER(NombreProveedor) [NombreProveedor] from dbo.proveedor  
	end	

	else if @Valor='Comprovante'
	begin
	select id,Tipo_Comprovante_Fiscal as [name]  from dbo.Ncf_Comprovante  
	end	

	else if @Valor='document'
	begin
  
  	select           1 as [id],'Cedula'as[name]
			union select 2 as [id],'RNC'as[name]
			union select 3 as [id],'Pasaporte'as[name]
			union select 2 as [id],'Licencia'as[name]
		 
	end	

		else if @Valor='sexso'
	begin
	 	select           1 as [id],'Masculino'as[name]
			union select 2 as [id],'Femenino'as[name]
			union select 3 as [id],'Otros'as[name]
	end	
GO
/****** Object:  StoredProcedure [dbo].[FILL_DROP_DOWN_not]    Script Date: 28/10/2018 16:22:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[FILL_DROP_DOWN_not]
	@DropDownName VARCHAR(100)
AS
BEGIN
	
	IF LOWER(@DropDownName) = 'Comprovante'
	BEGIN
		SELECT   [id]
      ,[Tipo_Comprovante_Fiscal]
     
       
  FROM [dbo].[Ncf_Comprovante];

END
END
--	IF LOWER(@DropDownName) = 'phonetype'
--	BEGIN
--		Select Distinct PhoneType as [Key],
--		(
--			Case PhoneType
--				When 'CEL' then 'Celular'
--				When 'OFI' then 'Oficina'
--				When 'RES' then 'Residencia'
--				When 'TEL' then 'Telefono'
--			else
--				PhoneType
--		end) as [Value]
--		FROM [dbo].contactPhones
--		Where
--		PhoneType not in('O','C','BEE')
--	END

--	IF LOWER(@DropDownName) = 'emailtype'
--	BEGIN
--			Select Distinct emailType as [Key],
--				[emailType] as [Value]
--			FROM [Entity].contactEmail
--	END

--	IF LOWER(@DropDownName) = 'transactionreason'
--	BEGIN
--			Select transactionReasonName as [Key],
--				cast(transactionReasonId as varchar) as [Value]
--			FROM [Loan].[transactionReason]
--	END
--END
GO
/****** Object:  StoredProcedure [dbo].[GET_EMPLEADO_COMBO]    Script Date: 28/10/2018 16:22:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[GET_EMPLEADO_COMBO]

AS

BEGIN 
SELECT idtrabajador,lower(nombre+' '+apellidos)NombreCom FROM dbo.trabajador where StatusE=1

END
GO
/****** Object:  StoredProcedure [dbo].[IMPRIMIR_COTIZACION]    Script Date: 28/10/2018 16:22:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[IMPRIMIR_COTIZACION]
@id_cotizacion int
as
SELECT * FROM [dbo].[VW_COTIZACIONES] WHERE [dbo].[VW_COTIZACIONES].[No. Cotizacion] = @id_cotizacion
GO
/****** Object:  StoredProcedure [dbo].[INGRESAR_FACTURA]    Script Date: 28/10/2018 16:22:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[INGRESAR_FACTURA]
@nombre_trabajador varchar(100),
@tipo_pago varchar(25),
@medio_pago varchar(30),
@id_venta int,
@id_trabajador int,
@id_cliente int,
@cantidad_articulos int,
@subtotal decimal(18,2),
@itbis decimal(9,2),
@total decimal(18,2)
AS
INSERT INTO [dbo].[Factura]
           ([nombre_trabajador]
           ,[tipo_pago]
           ,[medio_pago]
           ,[id_venta]
           ,[id_trabajador]
		   ,[id_cliente]
           ,[cantidad_articulos]
           ,[subtotal]
           ,[itbis]
           ,[total]
		   ,[numero_factura])
     VALUES
           (@nombre_trabajador
           ,@tipo_pago
           ,@medio_pago
           ,@id_venta
           ,@id_trabajador
		   ,@id_cliente
           ,@cantidad_articulos
           ,@subtotal
           ,@itbis
           ,@total
		   ,('NFC'+CONVERT(VARCHAR(50),UPPER(SUBSTRING(@nombre_trabajador, (1), (2)))+'000000')+CONVERT(VARCHAR(10),@id_venta)))



GO
/****** Object:  StoredProcedure [dbo].[INSERTAR_COTIZACION]    Script Date: 28/10/2018 16:22:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[INSERTAR_COTIZACION]
@idcliente INT,
@idtrabajador INT,
@cantidad INT,
@subtotal DECIMAL(18, 2),
@itbis DECIMAL(9,2),
@total DECIMAL(18, 2),
@id_cotizacion int output
AS
BEGIN
INSERT INTO [dbo].[cotizacion]
           ([idcliente]
           ,[idtrabajador]
           ,[cantidad]
           ,[subtotal]
           ,[itbis]
           ,[total]
           ,[fecha]
           ,[estatus])
     VALUES
           (@idcliente
           ,@idtrabajador
           ,@cantidad
           ,@subtotal
           ,@itbis
           ,@total
           ,GETDATE()
           ,1)

SET @id_cotizacion = @@identity
END
GO
/****** Object:  StoredProcedure [dbo].[INSERTAR_DETALLES_COTIZADOR_PRODUCTOS]    Script Date: 28/10/2018 16:22:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[INSERTAR_DETALLES_COTIZADOR_PRODUCTOS]
@idcotizacion INT,
@producto VARCHAR(50),
@cantidad INT,
@precioVenta DECIMAL(18,2),
@itbis DECIMAL(9,2),
@subtotal DECIMAL(18,2),
@total DECIMAL(18,2)
AS
INSERT INTO [dbo].[detalle_cotizacion_productos]
           ([idcotizacion]
           ,[producto]
           ,[cantidad]
           ,[precioVenta]
           ,[itbis]
           ,[subtotal]
           ,[total])
     VALUES
           (@idcotizacion
           ,@producto
           ,@cantidad
           ,@precioVenta
           ,@itbis
           ,@subtotal
           ,@total)
GO
/****** Object:  StoredProcedure [dbo].[LIST_ARTICULOS_X_CODIGO]    Script Date: 28/10/2018 16:22:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[LIST_ARTICULOS_X_CODIGO]
@CODIGO VARCHAR(50),
@COPIAS INT
AS
BEGIN
DECLARE @STMT VARCHAR(MAX);
DECLARE @QUERY VARCHAR(1000);
DECLARE @COUNTER INT;

SET @COUNTER = 1;
SET @QUERY = '';

SET @STMT = ('SELECT * FROM DBO.articulo WHERE CodigoBarra =' + CHAR(39) + UPPER(@CODIGO) + CHAR(39)); 

WHILE(@COUNTER <= @COPIAS)
BEGIN
  IF(@COUNTER = @COPIAS)
    BEGIN
	  SET @QUERY = @QUERY + @STMT;
	END
  ELSE
    BEGIN
	  SET @QUERY = @QUERY + @STMT + CHAR(13) + 'UNION ALL' + CHAR(13)
	END
  SET @COUNTER = @COUNTER + 1;
END

EXEC(@QUERY)
END
GO
/****** Object:  StoredProcedure [dbo].[ListaProveedores]    Script Date: 28/10/2018 16:22:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[ListaProveedores]
@id int

as
begin
SELECT [idproveedor]
      ,[razon_social]
      ,[NombreProveedor]
      ,[tipo_documento]
      ,[num_documento]
      ,[direccion]
      ,[telefono]
      ,[email]
      ,[url]
      ,[statu]
      ,[FechaAdiciona]    
      ,[UsuarioAdiciona]      
  FROM [dbventas].[dbo].[proveedor] where idproveedor=@id and statu=1

  end
GO
/****** Object:  StoredProcedure [dbo].[REDUCIR_CANTIDAD_ARTICULO]    Script Date: 28/10/2018 16:22:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[REDUCIR_CANTIDAD_ARTICULO]
@idarticulo int,
@cantidad int
as
begin
declare @status bit;
declare @enExistencia int;
declare @deducido int;
set @enExistencia = 0;
set @status = 1;
set @deducido = 0;

if(exists(SELECT * FROM [dbo].[articulo] WHERE [idarticulo] = @idarticulo))
BEGIN
SELECT @enExistencia = [cantidad] FROM [dbo].[articulo] WHERE [idarticulo] = @idarticulo;

if(@enExistencia <= 0)
begin
set @status = 0;
  end
    else
   begin
 set @deducido = @enExistencia - @cantidad;
end
UPDATE [dbo].[articulo]
   SET [cantidad] = @deducido
      ,[estado] = @status
 WHERE idarticulo = @idarticulo
 end
 END
GO
/****** Object:  StoredProcedure [dbo].[REGISTRAR_USUARIO]    Script Date: 28/10/2018 16:22:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[REGISTRAR_USUARIO]
@id INT,
@Usuario VARCHAR(50),
@Clave VARCHAR(50),
@RolID int,
@Statud bit,
@id_trabajador int


AS
BEGIN
  IF(@id <= 0)
    BEGIN
      INSERT INTO [dbo].[USERS]
             ([Usuario]
             ,[Clave]
             ,[RolID]
             ,[Statud])
       VALUES
           (@Usuario
           ,@Clave
           ,@RolID
           ,@Statud)
    END
  ELSE
    BEGIN
	  UPDATE [dbo].[USERS]
	  SET Usuario = @Usuario,
	      Clave = @Clave,
		  RolID = @RolID,
		  Statud = @Statud
	  WHERE id = @id
	END
END
 
BEGIN
DECLARE @idUsu int  = (select max(id) from dbo.USERS)
 DECLARE @ident int = (select max(id)+1 from dbo.UsuarioTrabajador)
  INSERT INTO [dbventas].[dbo].[UsuarioTrabajador]
  SELECT TOP 1
       @ident[id]
      ,@id_trabajador[id_trabajador]
      ,@idUsu[id_usuario]
      ,GETDATE()[fecha_asignacion]
      ,NULL[fecha_deasinacion]
      ,1[status_assignacion]
      ,null[usuarioAdiciona]
      ,NULL[usuarioModifica]
      ,GETDATE()[fechaAdiciona]
      ,NULL[fechaModifica]
FROM [dbventas].[dbo].[UsuarioTrabajador]

  END
GO
/****** Object:  StoredProcedure [dbo].[REGISTRAR_USUARIO_20180807]    Script Date: 28/10/2018 16:22:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[REGISTRAR_USUARIO_20180807]
@id INT,
@Usuario VARCHAR(50),
@Clave VARCHAR(50),
@RolID int,
@Statud bit,
@id_trabajador int


AS
BEGIN
  IF(@id <= 0)
    BEGIN
      INSERT INTO [dbo].[USERS]
             ([Usuario]
             ,[Clave]
             ,[RolID]
             ,[Statud])
       VALUES
           (@Usuario
           ,@Clave
           ,@RolID
           ,@Statud)
    END
  ELSE
    BEGIN
	  UPDATE [dbo].[USERS]
	  SET Usuario = @Usuario,
	      Clave = @Clave,
		  RolID = @RolID,
		  Statud = @Statud
	  WHERE id = @id
	END
END
 
BEGIN
DECLARE @idUsu int  = (select max(id) from dbo.USERS)
 DECLARE @ident int = (select max(id)+1 from dbo.UsuarioTrabajador)
  INSERT INTO [dbventas].[dbo].[UsuarioTrabajador]
  SELECT TOP 1
       @ident[id]
      ,@id_trabajador[id_trabajador]
      ,@idUsu[id_usuario]
      ,GETDATE()[fecha_asignacion]
      ,NULL[fecha_deasinacion]
      ,1[status_assignacion]
      ,null[usuarioAdiciona]
      ,NULL[usuarioModifica]
      ,GETDATE()[fechaAdiciona]
      ,NULL[fechaModifica]
FROM [dbventas].[dbo].[UsuarioTrabajador]

  END
GO
/****** Object:  StoredProcedure [dbo].[SELECT_EMPLOYEE_BY_ID]    Script Date: 28/10/2018 16:22:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[SELECT_EMPLOYEE_BY_ID]
@ID INT
AS
SELECT [idtrabajador]
      ,[nombre]
      ,[apellidos]
      ,[sexo]
      ,[Fecha_nac]
      ,[num_documento]
      ,[direccion]
      ,[telefono]
      ,[email]
      ,[StatusE]
      ,[FechaModifica]
      ,[UsuarioModifica]
      ,[FechaAdiciona]
      ,[UsuarioAdiciona]
  FROM [dbo].[trabajador] WHERE idtrabajador = @ID

GO
/****** Object:  StoredProcedure [dbo].[SP_BUSCAR_FACTURA_X_ID]    Script Date: 28/10/2018 16:22:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_BUSCAR_FACTURA_X_ID]
@id_factura int,
@id_venta int
AS
SELECT [id_factura]
      ,[id_cliente]
      ,[nombre_trabajador]
      ,[tipo_pago]
      ,[fecha]
      ,[medio_pago]
      ,[id_venta]
      ,[id_trabajador]
      ,[cantidad_articulos]
      ,[subtotal]
      ,[itbis]
      ,[total]
      ,[numero_factura]
  FROM [dbo].[Factura] WHERE id_venta = id_venta OR id_factura = @id_factura

GO
/****** Object:  StoredProcedure [dbo].[SP_CREAR_CUENTA_X_COBRAR]    Script Date: 28/10/2018 16:22:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_CREAR_CUENTA_X_COBRAR]
@id_cliente int
,@valor decimal(18,2)
,@usuario varchar(50)
,@id_venta int
as
INSERT INTO [dbo].[cuentas_x_cobrar]
           ([id_cliente]
           ,[fecha]
           ,[valor]
           ,[pagado]
           ,[usuario]
		   ,[id_venta])
     VALUES
           (@id_cliente
           ,GETDATE()
           ,@valor
           ,0
           ,@usuario
		   ,@id_venta)

GO
/****** Object:  StoredProcedure [dbo].[SP_CUENTA_POR_COBRAR]    Script Date: 28/10/2018 16:22:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_CUENTA_POR_COBRAR]
 @id INT
,@id_cliente INT
,@valor DECIMAL(9,2)
,@pagado DECIMAL(9,2)
,@usuario VARCHAR(50)
,@idFactura varchar(50)
,@estado bit
AS

BEGIN 
IF EXISTS(SELECT * FROM dbo.cuentas_x_cobrar where id=@id and pagado=0)

UPDATE dbo.cuentas_x_cobrar set valor=@valor,usuario=@usuario,pagado=@estado
where id=id

--else

--insert into dbo.cuentas_x_cobrar values(
--@id_cliente
--,GETDATE()
--,@valor
--,@pagado
--,@usuario
--)
 

INSERT INTO MovimientosPagosYcobranzas 
SELECT 
      'Cuenta por Cobrar'[DetalleMov]
      ,getdate()[fechaPago]
      ,@idFactura[idFactura]
      ,@valor[cantidadPagada]
      ,@estado[statud]
      ,@usuario[usuarioPago]
      ,@id [id_cxc]
      ,null[id_cxp]


END
GO
/****** Object:  StoredProcedure [dbo].[SP_GET_ARTICULO]    Script Date: 28/10/2018 16:22:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[SP_GET_ARTICULO]


@codigo varchar(30)
,@nom varchar(50)

AS

BEGIN

SELECT        idarticulo, nombre, idcategoria, Codigo, Imag_Url, descripcion, precioVenta, precioCompra, cantidad, estado, idProveedor, CodigoBarra
FROM            dbo.articulo
WHERE CodigoBarra LIKE '%'+@codigo+'%' or nombre like '%'+@nom+'%'

END
GO
/****** Object:  StoredProcedure [dbo].[SP_GET_ARTICULO_LOAD]    Script Date: 28/10/2018 16:22:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[SP_GET_ARTICULO_LOAD]
as 
BEGIN
SELECT [idarticulo]
      ,[CodigoBarra]
      ,[nombre]
      ,[idcategoria]
      ,[Imag_Url]
      ,[descripcion]
      ,[precioVenta]
      ,[precioCompra]
      ,[cantidad]
      ,[idProveedor]
  FROM [dbventas].[dbo].[articulo] WHERE estado=1

END
GO
/****** Object:  StoredProcedure [dbo].[SP_GET_ARTICULOS_BUSCAR]    Script Date: 28/10/2018 16:22:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[SP_GET_ARTICULOS_BUSCAR]
 @codigo VARCHAR(50)
,@nombre VARCHAR(50)

as 
BEGIN

select            idarticulo
                 ,CodigoBarra
	             ,nombre
	             ,idcategoria
	             ,Imag_Url
	             ,descripcion
	             ,precioVenta
	             ,precioCompra 
from dbo.articulo
where 
CodigoBarra like '%'+@codigo+'%' or nombre like +'%'+ @nombre+'%'
and estado=1
END
GO
/****** Object:  StoredProcedure [dbo].[SP_GET_ARTICULOS_BUSCAR_X_CODIGO]    Script Date: 28/10/2018 16:22:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_GET_ARTICULOS_BUSCAR_X_CODIGO]
@codigo VARCHAR(50)
as 
BEGIN

select            idarticulo
                 ,codigo
	             ,nombre
	             ,idcategoria
	             ,Imag_Url
	             ,descripcion
	             ,precioVenta
	             ,precioCompra 
from dbo.articulo
where 
codigo=@codigo

END
GO
/****** Object:  StoredProcedure [dbo].[SP_GET_BUSCAR_PROVEEDOR]    Script Date: 28/10/2018 16:22:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[SP_GET_BUSCAR_PROVEEDOR]
@documento varchar(15),
@telefono varchar(15),
@nombre varchar(60)
as
SELECT [idproveedor]
      ,[razon_social]
      ,[NombreProveedor]
      ,[tipo_documento]
      ,[num_documento]
      ,[direccion]
      ,[telefono]
      ,[email]
      ,[url]
      ,iif([statu]=1,'Activo','Inactivo')[Estado]
      
  FROM [dbventas].[dbo].[proveedor]

  where  statu=1 and NombreProveedor like '%'+@nombre+'%' or telefono=@telefono or num_documento=@documento
  
GO
/****** Object:  StoredProcedure [dbo].[SP_GET_CATEGORIA_BUSCAR]    Script Date: 28/10/2018 16:22:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[SP_GET_CATEGORIA_BUSCAR]

@nombre VARCHAR(50)

as 
BEGIN

select          idcategoria
               ,nombre
			   ,descripcion
from dbo.categoria
where 
nombre like '%'+@nombre+'%'

END
GO
/****** Object:  StoredProcedure [dbo].[SP_GET_Categoria_LOAD]    Script Date: 28/10/2018 16:22:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[SP_GET_Categoria_LOAD]


as
begin 
select * from dbo.categoria
end
GO
/****** Object:  StoredProcedure [dbo].[SP_GET_CLIENTE_CXC]    Script Date: 28/10/2018 16:22:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_GET_CLIENTE_CXC]

@NumC VARCHAR(15),
@CodiC varchar(15),
@NomCom varchar(50)
AS
BEGIN 

SELECT  [id]
      ,[id_cliente]
      ,[num_documento]
      ,[CodigoCliente]
      ,[NombreCompleto]      
      ,[valor]
      ,[pagado]
  FROM [dbventas].[dbo].[wv_get_cliente_deuda]

  WHERE NombreCompleto LIKE '%'+@NomCom+'%' OR CodigoCliente=@CodiC or num_documento=@NumC

  end 
GO
/****** Object:  StoredProcedure [dbo].[SP_GET_CLIENTE_DEUDA]    Script Date: 28/10/2018 16:22:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  CREATE PROC [dbo].[SP_GET_CLIENTE_DEUDA]

  AS

  BEGIN 
  SELECT  
        [id]
	   ,[id_cliente]
      ,[num_documento]
      ,[CodigoCliente]
      ,[NombreCompleto]
	  ,[valor][Deuda Actual]
      ,iif([pagado]=0,'TIENE DEUDA','NO TIENE DEUDA')Estado
	  ,[id_factura]
  FROM [dbventas].[dbo].[wv_get_cliente_deuda]

  END
GO
/****** Object:  StoredProcedure [dbo].[SP_GET_CLIENTES_BUSCAR]    Script Date: 28/10/2018 16:22:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[SP_GET_CLIENTES_BUSCAR]

@CodigoCliente varchar(60),
@Identificacion varchar(15),
@Nombre_Completo varchar(50),
@Telefono  varchar(15)
as 
BEGIN
SELECT [idcliente]
      ,[nombre]
      ,[apellidos]
      ,[sexo]
      ,[fecha_nacimiento]
      ,[tipo_documento]
      ,[num_documento]
      ,[direccion]
      ,[telefono]
      ,[email]
      ,[CodigoCliente]
      FROM [dbo].[cliente]
	  where statu=1
 AND 
     [CodigoCliente]=@CodigoCliente 
or num_documento=@Identificacion
or nombre LIKE '%'+ @Nombre_Completo+'%'
OR [Telefono]=@Telefono
END
GO
/****** Object:  StoredProcedure [dbo].[sp_get_clientes_deudores]    Script Date: 28/10/2018 16:22:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sp_get_clientes_deudores]

as

begin 

select * from [dbo].[wv_get_cliente_deuda]
end

GO
/****** Object:  StoredProcedure [dbo].[SP_GET_CLIENTES_LOAD]    Script Date: 28/10/2018 16:22:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[SP_GET_CLIENTES_LOAD]
as 
BEGIN
SELECT [idcliente]
      ,[nombre]
      ,[apellidos]
      ,[sexo]
      ,[fecha_nacimiento]
      ,[tipo_documento]
      ,[num_documento]
      ,[direccion]
      ,[telefono]
      ,[email]
      ,[CodigoCliente]
      FROM [dbventas].[dbo].[cliente]
	  where statu=1

END
GO
/****** Object:  StoredProcedure [dbo].[SP_GET_COMBOBOX_CATEGORIA]    Script Date: 28/10/2018 16:22:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


      --codigo]
      --nombre]
      --idcategoria]
      --Imag_Url]
      --descripcion]
      --precioVenta]
      --precioCompra]
      --cantidad]
      --estado]
      --idProveedor]

	  create PROC [dbo].[SP_GET_COMBOBOX_CATEGORIA]
	  AS
	  BEGIN
	  SELECT idcategoria,nombre FROM categoria ORDER BY nombre ASC
	  END
GO
/****** Object:  StoredProcedure [dbo].[SP_GET_COMBOBOX_CLIENTE]    Script Date: 28/10/2018 16:22:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROC [dbo].[SP_GET_COMBOBOX_CLIENTE]

AS

BEGIN 
SELECT idcliente,upper(nombre +' '+apellidos)as NombreCompleto FROM dbo.cliente  
order by NombreCompleto
END
  
  --select 
  --c.id
  --,c.[id_cliente]
  --,cl.CodigoCliente
  --,cl.num_documento 
  --,(cl.nombre +''+ cl.apellidos) NombreCompleto   
  --,[fecha]
  --,[valor]
  --,[pagado] 
    
  --from [dbventas].[dbo].[cuentas_x_cobrar]c
  --left join dbo.cliente cl

  --on c.id_cliente=cl.idcliente

  --where cl.CodigoCliente='6-015'
  --      and cl.statu=1
		--and c.pagado=0

GO
/****** Object:  StoredProcedure [dbo].[SP_GET_COMBOBOX_PROVEEDOR]    Script Date: 28/10/2018 16:22:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


      --codigo]
      --nombre]
      --idcategoria]
      --Imag_Url]
      --descripcion]
      --precioVenta]
      --precioCompra]
      --cantidad]
      --estado]
      --idProveedor]

	  CREATE PROC [dbo].[SP_GET_COMBOBOX_PROVEEDOR]
	  AS
	  BEGIN
	  SELECT idproveedor,NombreProveedor FROM proveedor where statu=1 ORDER BY NombreProveedor ASC
	  END
GO
/****** Object:  StoredProcedure [dbo].[SP_GET_DROPDOWN_DERMOGRAFIA]    Script Date: 28/10/2018 16:22:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 
 CREATE PROC [dbo].[SP_GET_DROPDOWN_DERMOGRAFIA]  
@Valor varchar(25)='Default' 
,@id int =0

as
 

if @Valor='Default'
	begin
		select id_Pais,PaisNombre,id_Pais[id],PaisNombre[Valor] from dbo.Pais  
		ORDER BY PaisNombre
	end
else if @Valor='Provincia'
	begin
	select CiudadID,CiudadNombre from dbo.ciudad where id_pais=@id
		ORDER BY CiudadNombre
	end

	else if @Valor='Municipio'
	begin
	select CiudadID,CiudadNombre from dbo.ciudad where CiudadID=@id
	end	

	else if @Valor='categoria'
	begin
	select idcategoria,nombre from dbo.categoria  
	end	
	 
	 else if @Valor='proveedor'
	begin
	select idproveedor,UPPER(NombreProveedor) [NombreProveedor] from dbo.proveedor  
	end	

	else if @Valor='Comprovante'
	begin
	select id,Tipo_Comprovante_Fiscal  from dbo.Ncf_Comprovante  
	end	
GO
/****** Object:  StoredProcedure [dbo].[SP_GET_EMPLOYEES]    Script Date: 28/10/2018 16:22:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[SP_GET_EMPLOYEES]
 @NombreC varchar(80)
,@num_cedula varchar(15)
,@telefono varchar(15)

as

begin


SELECT [idtrabajador]
      ,[NombreCompleto]
      ,[sexo]
      ,[num_documento]
      ,[direccion]
      ,[telefono]
      ,[email]
      ,[Estado]
   
  FROM [dbventas].[dbo].[wv_get_employees]
where 
     NombreCompleto like '%'+@NombreC+'%'
  or telefono=@telefono
  or num_documento=@num_cedula
end
GO
/****** Object:  StoredProcedure [dbo].[SP_GET_FACTURA]    Script Date: 28/10/2018 16:22:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_GET_FACTURA]
@id_venta int
as
SELECT id_factura FROM FACTURA WHERE id_venta = @id_venta
GO
/****** Object:  StoredProcedure [dbo].[SP_GET_PROVEEDOR_BUSCAR]    Script Date: 28/10/2018 16:22:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[SP_GET_PROVEEDOR_BUSCAR]
@documento varchar(15),
@telefono varchar(15),
@nombre varchar(60)
as
SELECT [idproveedor]
      ,[razon_social]
      ,[NombreProveedor]
      ,[tipo_documento]
      ,[num_documento]
      ,[direccion]
      ,[telefono]
      ,[email]
      ,[url]
      ,[statu]
      ,[FechaAdiciona]
      ,[UsuarioAdiciona]      
  FROM [dbventas].[dbo].[proveedor]

  where NombreProveedor like '%'+@nombre+'%' or telefono=@telefono or num_documento=@documento
  and statu=1
GO
/****** Object:  StoredProcedure [dbo].[SP_GET_PROVEEDOR_LOAD]    Script Date: 28/10/2018 16:22:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[SP_GET_PROVEEDOR_LOAD]
as
SELECT [idproveedor]
      ,[razon_social]
      ,[NombreProveedor]
      ,[tipo_documento]
      ,[num_documento]
      ,[direccion]
      ,[telefono]
      ,[email]
      ,[url]
        
      
  FROM [dbventas].[dbo].[proveedor] where statu=1
GO
/****** Object:  StoredProcedure [dbo].[SP_GET_ROLL_DROP]    Script Date: 28/10/2018 16:22:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create proc [dbo].[SP_GET_ROLL_DROP]

AS

BEGIN 
SELECT id,Nombre FROM dbo.ROLES
END
GO
/****** Object:  StoredProcedure [dbo].[sp_get_searche_client_pagos]    Script Date: 28/10/2018 16:22:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  
CREATE proc [dbo].[sp_get_searche_client_pagos]
@num_documento varchar(15)
,@codigoCliente varchar(62)
,@NombComp varchar(80)

as

begin 

  SELECT  
        [id]
	   ,[id_cliente]
      ,[num_documento]
      ,[CodigoCliente]
      ,[NombreCompleto]
	  ,[valor][Deuda Actual]
      ,iif([pagado]=0,'TIENE DEUDA','NO TIENE DEUDA')Estado
	  ,[id_factura]
  FROM [dbventas].[dbo].[wv_get_cliente_deuda]

where codigocliente =@codigoCliente or num_documento=@num_documento or 
NombreCompleto like '%'+@NombComp+'%%'
end 
GO
/****** Object:  StoredProcedure [dbo].[SP_GET_USER_BY_NAME]    Script Date: 28/10/2018 16:22:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_GET_USER_BY_NAME]
@USERNAME VARCHAR(50)
AS 
SELECT u.[id]
      ,[Usuario]
      ,[Clave]
      ,[RolID]
	  ,ut.[id_trabajador]
      ,[Statud]
  FROM [dbo].[USERS]u inner join [UsuarioTrabajador]ut on u.id=ut.id_trabajador
  WHERE Usuario = @USERNAME
GO
/****** Object:  StoredProcedure [dbo].[SP_GET_VENTAS_DEL_DIA]    Script Date: 28/10/2018 16:22:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[SP_GET_VENTAS_DEL_DIA]
@fecha date
as
begin
DECLARE @TEMP TABLE(idventa int, idcliente int, idtrabajador int, fecha date, tc varchar(25), tv varchar(20), tcli varchar(50), it decimal(9,2), sub decimal(18,2), total decimal(18,2), pagada varchar(25))
insert into @TEMP EXEC VENTAS_DEL_DIA @fecha

select t.fecha, t.idventa, (c.nombre + ' ' + c.apellidos) AS cliente, t.idtrabajador, t.tc as tipo, t.tv as venta, t.tcli as categoria, t.it as itbis, t.sub as subtotal, t.total as total, t.pagada
from @TEMP t inner join
cliente c on c.idcliente = t.idcliente;
end
GO
/****** Object:  StoredProcedure [dbo].[SP_GET_VENTAS_DEL_MES]    Script Date: 28/10/2018 16:22:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[SP_GET_VENTAS_DEL_MES]
@FROM date,
@Tipo_de_Documento date
as
begin
DECLARE @TEMP TABLE(idventa int, idcliente int, idtrabajador int, fecha date, tc varchar(25), tv varchar(20), tcli varchar(50), it decimal(9,2), sub decimal(18,2), total decimal(18,2), pagada varchar(25))
insert into @TEMP EXEC VENTAS_DEL_DIA @FROM, @Tipo_de_Documento

select t.fecha, t.idventa, (c.nombre + ' ' + c.apellidos) AS cliente, t.idtrabajador, t.tc as tipo, t.tv as venta, t.tcli as categoria, t.it as itbis, t.sub as subtotal, t.total as total, t.pagada
from @TEMP t inner join
cliente c on c.idcliente = t.idcliente;
end

GO
/****** Object:  StoredProcedure [dbo].[SP_INGRESAR_DETALLE_VENTA]    Script Date: 28/10/2018 16:22:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_INGRESAR_DETALLE_VENTA]
@idventa int,
@producto varchar(50),
@cantidad int,
@precio_venta decimal(18,2),
@descuento decimal(18,2),
@itbis decimal(9,2)
AS 
BEGIN
INSERT INTO [dbo].[detalle_venta]
           ([idventa]
		   ,[producto]
           ,[cantidad]
           ,[precio_venta]
           ,[descuento]
           ,[itbis])
     VALUES
           (@idventa
		   ,@producto
		   ,@cantidad
           ,@precio_venta
           ,@descuento
           ,@itbis)
END
GO
/****** Object:  StoredProcedure [dbo].[SP_INGRESAR_VENTA]    Script Date: 28/10/2018 16:22:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_INGRESAR_VENTA]
@idtrabajador int,
@id_cliente int,
@tipo_comprobante varchar(20),
@tipo_venta varchar(20),
@tipo_cliente varchar(20),
@itbis decimal(9, 2),
@subtotal decimal(18, 2),
@total decimal(18,2),
@ventaid int output
as
BEGIN
 INSERT INTO [dbo].[venta]


           (
		     [idcliente]
		   ,[idtrabajador]
           ,[fecha]
           ,[tipo_comprobante]
           ,[tipo_venta]
           ,[tipo_cliente]
           ,[itbis]
           ,[subtotal]
           ,[total])
     VALUES
           (
		   
		    @id_cliente
		   ,@idtrabajador
           ,GETDATE()
           ,@tipo_comprobante
           ,@tipo_venta
           ,@tipo_cliente
           ,@itbis
           ,@subtotal
           ,@total)

if(@@IDENTITY > 0)
BEGIN
 SET @ventaid = @@IDENTITY
END
ELSE
BEGIN
 SET @ventaid = 0
END
END
GO
/****** Object:  StoredProcedure [dbo].[SP_LOGIN]    Script Date: 28/10/2018 16:22:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_LOGIN]
@usuario varchar(50),
@contrasena varchar(50),
@NombreC varchar(80) output,
@rolid int output,
@id_trabajador int output
AS
BEGIN
 
 SELECT @rolid=RolID,@NombreC=NombreCompleto,@id_trabajador=idtrabajador
from dbo.wv_usuario_trabajador 
WHERE Usuario = @usuario and Clave = @contrasena
 
 
 IF  (@rolid<=0)
 BEGIN
   SET @rolid = 0
   SET @NombreC = ''
   SET @id_trabajador= 0
 END
END

GO
/****** Object:  StoredProcedure [dbo].[SP_SET_CATEGORIA]    Script Date: 28/10/2018 16:22:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROC [dbo].[SP_SET_CATEGORIA]
@idCat int
,@nom varchar(50)
,@Desc varchar(256)

as

begin 
if exists(select * from categoria where idcategoria=@idCat)
update categoria set nombre=@nom,descripcion=@Desc where idcategoria=@idCat
else

insert into categoria (nombre,descripcion)values(@nom,@Desc)
end
GO
/****** Object:  StoredProcedure [dbo].[SP_SET_Categoria_UPDATE_INSERT]    Script Date: 28/10/2018 16:22:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[SP_SET_Categoria_UPDATE_INSERT]

@IdCategoria int,
@NomCategiria VARCHAR(50),
@Descripcion varchar(256)

as

begin 
if exists(select * from dbo.categoria where idcategoria=@IdCategoria)
update dbo.categoria set nombre=@NomCategiria,descripcion=@Descripcion
where idcategoria=@IdCategoria
else

insert into dbo.categoria  values(@NomCategiria,@Descripcion)
end
GO
/****** Object:  StoredProcedure [dbo].[SP_SET_CLIENTE_DELETE]    Script Date: 28/10/2018 16:22:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 CREATE PROC [dbo].[SP_SET_CLIENTE_DELETE]
 
     
 @idcliente INT 
--,@status    BIT
,@UsuarioModifica VARCHAR(50)

AS

BEGIN
UPDATE dbo.cliente set  statu=0
                       ,UsuarioAdiciona=@UsuarioModifica
					    where idcliente=@idcliente

END
GO
/****** Object:  StoredProcedure [dbo].[SP_SET_CLIENTE_INSERT_UPDATE]    Script Date: 28/10/2018 16:22:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_SET_CLIENTE_INSERT_UPDATE]
    
	   @idcliente         int
      ,@nombre			  varchar(50)
      ,@apellidos		  varchar(40)
      ,@sexo			  char(10)
      ,@fecha_nacimiento  date
      ,@tipo_documento	  varchar(20)
      ,@num_documento	  varchar(8)
      ,@direccion		  varchar(100)
      ,@telefono		  varchar(15)
      ,@email			  varchar(50)
	  ,@status            bit
	  --,@FechaAdiciona     datetime
   --   ,@FechaModifica     datetime
      ,@UsuarioAdiciona   varchar(50)
      ,@UsuarioModifica	  varchar(50)
                
AS

BEGIN
IF EXISTS(select * from dbo.cliente where idcliente=@idcliente)

UPDATE dbo.cliente SET      
	 				   nombre		     =	@nombre			
					   ,apellidos	     =	@apellidos		
					   ,sexo			 =	@sexo			
					   ,fecha_nacimiento =	@fecha_nacimiento
					   ,tipo_documento	 =	@tipo_documento	
					   ,num_documento	 =	@num_documento	
					   ,direccion		 =	@direccion		
					   ,telefono		 =	@telefono		
					   ,email            =	@email
					   ,statu            =  @status
			           ,FechaAdiciona    =  GETDATE()
                      
                       ,UsuarioAdiciona  =  @UsuarioAdiciona
                       --,UsuarioModifica  =  @UsuarioModifica
                       ,HostName         = HOST_NAME()
					   

where idcliente=@idcliente
					   
ELSE

INSERT INTO dbo.cliente values(

                                @nombre			
							   ,@apellidos		
							   ,@sexo			
							   ,@fecha_nacimiento
							   ,@tipo_documento	
							   ,@num_documento	
							   ,@direccion		
							   ,@telefono		
							   ,@email
							   ,@status
							   ,GETDATE()
							   ,NULL
							   ,@UsuarioAdiciona
							   ,null--@UsuarioModifica
							   ,HOST_NAME()
                              )


END
GO
/****** Object:  StoredProcedure [dbo].[SP_SET_CLIENTE_INSERT_UPDATE_20180528]    Script Date: 28/10/2018 16:22:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROC [dbo].[SP_SET_CLIENTE_INSERT_UPDATE_20180528]
    
	   @idcliente         int
      ,@nombre			  varchar(50)
      ,@apellidos		  varchar(40)
      ,@sexo			  char(10)
      ,@fecha_nacimiento  date
      ,@tipo_documento	  varchar(20)
      ,@num_documento	  varchar(8)
      ,@direccion		  varchar(100)
      ,@telefono		  varchar(15)
      ,@email			  varchar(50)
	  ,@status            bit
	  ,@FechaAdiciona     datetime
      --,@FechaModifica     datetime
      ,@UsuarioAdiciona   varchar(50)
      --,@UsuarioModifica	  varchar(50)
                
AS
declare @FechaModifica  datetime=getdate() 

BEGIN
IF EXISTS(select * from dbo.cliente where idcliente=@idcliente)

UPDATE dbo.cliente SET      
	 				   nombre		     =	@nombre			
					   ,apellidos	     =	@apellidos		
					   ,sexo			 =	@sexo			
					   ,fecha_nacimiento =	@fecha_nacimiento
					   ,tipo_documento	 =	@tipo_documento	
					   ,num_documento	 =	@num_documento	
					   ,direccion		 =	@direccion		
					   ,telefono		 =	@telefono		
					   ,email            =	@email
					   ,statu            =  @status
			           ,FechaAdiciona    =  @FechaAdiciona
                       ,FechaModifica    =  @FechaModifica
                       ,UsuarioAdiciona  =  @UsuarioAdiciona
                       --,UsuarioModifica  =  @UsuarioModifica
                       ,HostName         = HOST_NAME()
					   

where idcliente=@idcliente
					   
ELSE

INSERT INTO dbo.cliente values(

                                @nombre			
							   ,@apellidos		
							   ,@sexo			
							   ,@fecha_nacimiento
							   ,@tipo_documento	
							   ,@num_documento	
							   ,@direccion		
							   ,@telefono		
							   ,@email
							   ,@status
							   ,getdate()
							   ,@FechaModifica
							   ,@UsuarioAdiciona
							   ,null--@UsuarioModifica
							   ,HOST_NAME()
                              )


END

GO
/****** Object:  StoredProcedure [dbo].[SP_SET_DELETE_ARTICULO]    Script Date: 28/10/2018 16:22:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_SET_DELETE_ARTICULO]
@codigo int 
,@estado bit
AS

BEGIN 
UPDATE dbo.articulo SET estado=@estado where idarticulo=@codigo

END
GO
/****** Object:  StoredProcedure [dbo].[SP_SET_DELETE_PROVEEDOR]    Script Date: 28/10/2018 16:22:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[SP_SET_DELETE_PROVEEDOR]

@codigo int 
,@estado bit
as
begin

update dbo.proveedor set statu=@estado where idproveedor=@codigo

end
GO
/****** Object:  StoredProcedure [dbo].[SP_SET_EMPLEADO]    Script Date: 28/10/2018 16:22:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
       CREATE PROC [dbo].[SP_SET_EMPLEADO]

       @idtrabajador    int
      ,@nombre          varchar(20)
      ,@apellidos       varchar(40)
      ,@sexo            char(10)
      ,@Fecha_nac       datetime
      ,@num_documento   varchar(15)
      ,@direccion       varchar(100)
      ,@telefono        varchar(15)
      ,@email           varchar(50)
      ,@StatusE         bit
      ,@UsuarioAdiciona varchar(50)
	  ,@UsuarioModifica varchar(50)

	  AS

	  BEGIN 
	  if exists(select * from dbo.trabajador where idtrabajador=@idtrabajador)
	  UPDATE dbo.trabajador
	  set

	   nombre         =@nombre         
	  ,apellidos      =@apellidos      
	  ,sexo           =@sexo           
	  ,Fecha_nac      =@Fecha_nac      
	  ,num_documento  =@num_documento  
	  ,direccion      =@direccion      
	  ,telefono       =@telefono       
	  ,email          =@email          
	  ,StatusE        =@StatusE    
	  ,FechaModifica  =GETDATE()
	  ,UsuarioModifica=@UsuarioModifica

	  WHERE idtrabajador=@idtrabajador;
	  else

	  INSERT INTO [dbo].[trabajador]
           ([nombre]
           ,[apellidos]
           ,[sexo]
           ,[Fecha_nac]
           ,[num_documento]
           ,[direccion]
           ,[telefono]
           ,[email]
           ,[StatusE]
           ,[FechaAdiciona]
           ,[FechaModifica]
           ,[UsuarioAdiciona]
           ,[UsuarioModifica])
     VALUES
           (
		   @nombre          
		   ,@apellidos       
		   ,@sexo            
		   ,@Fecha_nac       
		   ,@num_documento   
		   ,@direccion       
		   ,@telefono        
		   ,@email           
		   ,@StatusE        
		   ,GETDATE()   
		   ,NULL   
		   ,@UsuarioAdiciona 
		   ,NULL	
		   )
		    
	  END
GO
/****** Object:  StoredProcedure [dbo].[SP_SET_INSERT_UPDATE_ARTICULO]    Script Date: 28/10/2018 16:22:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[SP_SET_INSERT_UPDATE_ARTICULO]
    @idarticulo int ,
	@codigo varchar(50)  ,
	@nombre varchar(50)  ,
	@idcategoria int  ,
	@Imag_Url varchar(250) ,
	@descripcion varchar(200) ,
	@precioVenta decimal(9, 2) ,
	@precioCompra decimal(9, 2) ,
	@cantidad decimal(9, 2) ,
	@estado bit ,
	@idProveedor int 

AS
BEGIN 
IF EXISTS(SELECT * FROM dbo.articulo where idarticulo=@idarticulo)
UPDATE [dbo].[articulo]
   SET 
       [codigo]       = @codigo
	  ,[nombre]       = @nombre
      ,[idcategoria]  = @idcategoria
      ,[Imag_Url]     = @Imag_Url
      ,[descripcion]  = @descripcion
      ,[precioVenta]  = @precioVenta
      ,[precioCompra] = @precioCompra
      ,[cantidad]     = @cantidad
      ,[estado]       = @estado
      ,[idProveedor]  = @idProveedor

 WHERE idarticulo=@idarticulo
else

INSERT INTO [dbo].[articulo]
           ([codigo]
           ,[nombre]
           ,[idcategoria]
           ,[Imag_Url]
           ,[descripcion]
           ,[precioVenta]
           ,[precioCompra]
           ,[cantidad]
           ,[estado]
           ,[idProveedor])
     VALUES
           (
		    @codigo
		   ,@nombre
		   ,@idcategoria
		   ,@Imag_Url
		   ,@descripcion
		   ,@precioVenta
		   ,@precioCompra
		   ,@cantidad
		   ,@estado
		   ,@idProveedor
		   )

END
GO
/****** Object:  StoredProcedure [dbo].[SP_SET_INSERT_UPDATE_INGRESO]    Script Date: 28/10/2018 16:22:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[SP_SET_INSERT_UPDATE_INGRESO]

       @idingreso            int            
      ,@idproveedor          int
      ,@fecha                date 
      ,@tipo_comprobante     varchar(20) 
      --,@serie                varchar(20) 
      --,@correlativo          varchar(7)
      ,@Itbis                decimal(9,2)  
      ,@FechaAdiciona        datetime
      ,@FechaModifica        datetime 
      ,@UsuarioAdiciona      varchar(50)
      ,@UsuarioModifica      varchar(50)
	  ,@idarticulo           int 
	  ,@precio_compra        money
	  ,@precio_venta         money
	  ,@stock_inicial        int
	  ,@stock_actual         int
	  ,@fecha_produccion     date
	  ,@fecha_vencimiento    date
	 
	  AS

	  BEGIN
	   declare @id_ingre int
	  IF EXISTS(SELECT * FROM [dbo].[ingreso] WHERE idingreso=@idingreso) 
	
	  UPDATE [dbo].[ingreso]
	       
      SET    
          [idproveedor]       =@idproveedor     
         ,[fecha]             =@fecha           
         ,[tipo_comprobante]  =@tipo_comprobante
         --,[serie]             =@serie           
         --,[correlativo]       =@correlativo     
         ,[igv]               =@Itbis           
         ,[FechaAdiciona]     =@FechaAdiciona   
         ,[FechaModifica]     =@FechaModifica   
         ,[UsuarioAdiciona]   =@UsuarioAdiciona 
         ,[UsuarioModifica]   =@UsuarioModifica 
     
	  WHERE [idingreso]=@idingreso

	  ELSE
	  
INSERT INTO [dbo].[ingreso]
           (
            [idproveedor]
           ,[fecha]
           ,[tipo_comprobante]
           --,[serie]
           --,[correlativo]
           ,[igv]
           ,[FechaAdiciona]
           ,[FechaModifica]
           ,[UsuarioAdiciona]
           ,[UsuarioModifica])
     VALUES
           
		   ( 
		  
		    @idproveedor     
		   ,@fecha           
		   ,@tipo_comprobante
           --,@serie           
           --,@correlativo     
           ,@Itbis           
           ,@FechaAdiciona   
           ,@FechaModifica   
           ,@UsuarioAdiciona 
           ,@UsuarioModifica) 
		set  @id_ingre=(select max(idingreso) from [dbo].[ingreso] )

INSERT INTO [dbo].detalle_ingreso
SELECT  
      
       @id_ingre[idingreso]
      ,@idarticulo[idarticulo]
      ,@precio_compra [precio_compra]
      ,@precio_venta [precio_venta]
      ,@stock_inicial [stock_inicial]
      ,@stock_inicial [stock_actual]
      ,@fecha_produccion [fecha_produccion]
      ,@fecha_vencimiento [fecha_vencimiento]
  


	  END
GO
/****** Object:  StoredProcedure [dbo].[SP_SET_INSERTAR_ARTICULOS_INGRESO]    Script Date: 28/10/2018 16:22:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[SP_SET_INSERTAR_ARTICULOS_INGRESO]

 
  @nombre              varchar(50)
 ,@idcategoria         int
 ,@Codigo              varchar(50)
 ,@Imag_Url            varchar(250)
 ,@descripcion         varchar(200)
 ,@precioVenta         decimal(9,2)
 ,@precioCompra        decimal(9,2)
 ,@cantidad            decimal(9,2)
 ,@estado              bit
 ,@idProveedor         int
 ,@idingreso           int
 ,@fecha               date
 ,@tipo_comprobante    varchar(20)
 ,@igv                 decimal(9,2)
 ,@UsuarioAdiciona     varchar(50)
 ,@stock_inicial       int
 ,@fecha_produccion    date
 ,@fecha_vencimiento   date

 AS


 BEGIN 
INSERT INTO [dbo].[articulo]
           ([nombre]
           ,[idcategoria]
           ,[Codigo]
           ,[Imag_Url]
           ,[descripcion]
           ,[precioVenta]
           ,[precioCompra]
           ,[cantidad]
           ,[estado]
           ,[idProveedor])
     VALUES
           (
		    @nombre       
		   ,@idcategoria  
		   ,@Codigo       
		   ,@Imag_Url     
		   ,@descripcion  
		   ,@precioVenta  
		   ,@precioCompra 
		   ,@cantidad     
		   ,@estado       
		   ,@idProveedor  
		   );
		   
		   --DECLARE @cd varchar(30)=(select max(idarticulo) from [dbventas].[dbo].[articulo]);
	DECLARE @cd INT;
	SET @cd=@@IDENTITY
	PRINT @cd;
INSERT INTO [dbo].[ingreso]
           ([CodigBarra]
           ,[idproveedor]
           ,[fecha]
           ,[tipo_comprobante]
           ,[igv]
           ,[FechaAdiciona]
           ,[FechaModifica]
           ,[UsuarioAdiciona]
           ,[UsuarioModifica])
     VALUES

           (
		    @cd
		   ,@idProveedor		   
		   ,@fecha
		   ,@tipo_comprobante
		   ,@igv
		   ,GETDATE()
		   ,NULL
		   ,@UsuarioAdiciona
		   ,NULL
		   );
		  
		     DECLARE @codigoIng int=(select max(idingreso) from dbo.ingreso); 
			 DECLARE @art int=(select max(idarticulo) from dbo.articulo); 

		   INSERT INTO [dbo].[detalle_ingreso]
           ([iddetalle_ingreso]
           ,[idarticulo]
		   ,idingreso
           ,[precio_compra]
           ,[precio_venta]
           ,[stock_inicial]
           ,[stock_actual]
           ,[fecha_produccion]
           ,[fecha_vencimiento])
     VALUES
           (
		    @codigoIng
		   ,@art
		   ,@idingreso
		   ,@precioCompra
		   ,@precioVenta
		   ,@stock_inicial
		   ,@cantidad
		   ,@fecha_produccion
		   ,@fecha_vencimiento
		   )
		
 END








GO
/****** Object:  StoredProcedure [dbo].[SP_SET_PAGAR_CXC_NEW]    Script Date: 28/10/2018 16:22:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

 CREATE PROC [dbo].[SP_SET_PAGAR_CXC_NEW]

      
       @id_cliente int
      ,@fecha date
      ,@valor decimal(18,2)
      ,@pagado bit
      ,@usuario varchar(50)       
	  ,@fechaPago datetime
	  ,@idFactura  int
	  ,@cantidadPagada decimal(9,2)
	  ,@statud bit
	  ,@id_cxc int
	  
as

Begin 
IF EXISTS(SELECT * FROM [dbventas].[dbo].[cuentas_x_cobrar]cxc inner join 
[dbventas].[dbo].[Factura]f
on 
cxc.id_venta=f.id_venta
where 
cxc.id=@id_cxc and cxc.id_cliente=@id_cliente and f.id_factura=@idFactura
)
update [dbventas].[dbo].[cuentas_x_cobrar] set MontoAdeudado=valor where id=@id_cxc and id_cliente=@id_cliente; 
update [dbventas].[dbo].[cuentas_x_cobrar] set CantidadPagada=@cantidadPagada,pagado=@pagado,valor=valor-@cantidadPagada
where id=@id_cxc and id_cliente=@id_cliente;

 INSERT INTO [dbo].[MovimientosPagosYcobranzas]
           ([DetalleMov]
           ,[fechaPago]
           ,[idFactura]
           ,[cantidadPagada]
           ,[statud]
           ,[usuarioPago]
           ,[id_cxc]
           ,[id_cxp])
     VALUES
           (
		    'Cuenta Por Cobrar'
            ,GETDATE()
            ,@idFactura
            ,@cantidadPagada
            ,@statud
            ,@usuario
            ,@id_cxc
            ,null
			)
   
end
		   











 
 
 






  

GO
/****** Object:  StoredProcedure [dbo].[SP_SET_UDATE_INSERT_PROVEEDOR]    Script Date: 28/10/2018 16:22:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_SET_UDATE_INSERT_PROVEEDOR]

 @idproveedor        int  
,@razon_social varchar(150)
,@NombreProveedor varchar(50)
,@tipo_documento varchar(20)
,@num_documento varchar(15)
,@direccion nchar(100)
,@telefono varchar(10)
,@email varchar(50)
,@url varchar(100)
,@statu bit
,@UsuarioAdiciona varchar(50)
,@UsuarioModifica varchar(50)


as

begin 
if exists(select * from dbo.proveedor where idproveedor=@idproveedor)
UPDATE [dbo].[proveedor]
  
   SET [razon_social]        =@razon_social     
      ,[NombreProveedor]     =@NombreProveedor  
      ,[tipo_documento]      =@tipo_documento   
      ,[num_documento]       =@num_documento    
      ,[direccion]           =@direccion        
      ,[telefono]            =@telefono         
      ,[email]               =@email            
      ,[url]                 =@url              
      ,[statu]               =@statu    
      ,[FechaModifica]       =getdate()    
      ,[UsuarioModifica]     =@UsuarioModifica
           
 
  WHERE  idproveedor=@idproveedor
  ELSE
 INSERT INTO [dbo].[proveedor]
           ([razon_social]
           ,[NombreProveedor]
           ,[tipo_documento]
           ,[num_documento]
           ,[direccion]
           ,[telefono]
           ,[email]
           ,[url]
           ,[statu]
           ,[FechaAdiciona]
           ,[FechaModifica]
           ,[UsuarioAdiciona]
           ,[UsuarioModifica]
           ,[HostName])
     VALUES
           (
		    @razon_social     
		   ,@NombreProveedor  
		   ,@tipo_documento   
		   ,@num_documento    
		   ,@direccion  
		   ,@telefono   
		   ,@email      
		   ,@url        
		   ,@statu 
		   ,getdate()
		   ,NULL
		   ,@UsuarioAdiciona
		   ,NULL
		   ,HOST_NAME()
		   
		   )
		   
END 
GO
/****** Object:  StoredProcedure [dbo].[SP_TIPO_FACTURA]    Script Date: 28/10/2018 16:22:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_TIPO_FACTURA]
AS
BEGIN 
SELECT[id]
      ,[Tipo_Comprovante_Fiscal]
      
      
  FROM [dbventas].[dbo].[Ncf_Comprovante]

  END
GO
/****** Object:  StoredProcedure [dbo].[VENTAS_DEL_DIA]    Script Date: 28/10/2018 16:22:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[VENTAS_DEL_DIA]
@HOY date
AS
select *, [Pagada] = 'Pagada'  from venta v
where (v.[idventa]) not in (select p.id_venta from cuentas_x_cobrar p where p.fecha = @HOY)
and v.fecha = @HOY
union
select *, [Pagada] = 'Credito' from venta v
where (v.[idventa]) in (select p.id_venta from cuentas_x_cobrar p where p.fecha = @HOY)
and v.fecha = @HOY
GO
/****** Object:  StoredProcedure [dbo].[VENTAS_DEL_MES]    Script Date: 28/10/2018 16:22:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[VENTAS_DEL_MES]
@FROM date,
@TO date
AS
select *, [Pagada] = 'Pagada'  from venta v
where (v.[idventa]) not in (select p.id_venta from cuentas_x_cobrar p where p.fecha between @FROM and @TO)
and v.fecha between @FROM and @TO
union
select *, [Pagada] = 'Credito' from venta v
where (v.[idventa]) in (select p.id from cuentas_x_cobrar p where p.fecha between @FROM and @TO)
and v.fecha between @FROM and @TO

GO
