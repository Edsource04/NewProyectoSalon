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
    
    public partial class FACTURA_A_IMPRIMIR_Result
    {
        public int Id_Factura { get; set; }
        public string Cliente { get; set; }
        public string Empleado { get; set; }
        public string Tipo_de_Pago { get; set; }
        public System.DateTime Fecha { get; set; }
        public string Medio_de_Pago { get; set; }
        public int No__Articulos { get; set; }
        public decimal Subtotal { get; set; }
        public decimal ITBIS { get; set; }
        public decimal Total { get; set; }
        public string No__Factura { get; set; }
        public string Producto { get; set; }
        public int Cantidad { get; set; }
        public decimal Precio { get; set; }
        public string Descuento { get; set; }
        public Nullable<decimal> PITBIS { get; set; }
        public Nullable<decimal> PSUBITBIS { get; set; }
        public Nullable<decimal> PSUBTOTAL { get; set; }
    }
}