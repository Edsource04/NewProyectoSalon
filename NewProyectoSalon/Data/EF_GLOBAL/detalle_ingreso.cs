//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace Data.EF_GLOBAL
{
    using System;
    using System.Collections.Generic;
    
    public partial class detalle_ingreso
    {
        public int iddetalle_ingreso { get; set; }
        public int idarticulo { get; set; }
        public int idingreso { get; set; }
        public decimal precio_compra { get; set; }
        public decimal precio_venta { get; set; }
        public int stock_inicial { get; set; }
        public int stock_actual { get; set; }
        public System.DateTime fecha_produccion { get; set; }
        public System.DateTime fecha_vencimiento { get; set; }
    
        public virtual articulo articulo { get; set; }
        public virtual detalle_ingreso detalle_ingreso1 { get; set; }
        public virtual detalle_ingreso detalle_ingreso2 { get; set; }
    }
}
