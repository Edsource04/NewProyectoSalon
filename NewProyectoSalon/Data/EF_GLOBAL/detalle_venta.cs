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
    
    public partial class detalle_venta
    {
        public int iddetalle_venta { get; set; }
        public string producto { get; set; }
        public int idventa { get; set; }
        public int cantidad { get; set; }
        public decimal precio_venta { get; set; }
        public decimal descuento { get; set; }
        public Nullable<decimal> itbis { get; set; }
        public Nullable<decimal> sub_itbis { get; set; }
        public Nullable<decimal> sub_total { get; set; }
    
        public virtual venta venta { get; set; }
    }
}
