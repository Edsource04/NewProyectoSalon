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
    
    public partial class articulo
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public articulo()
        {
            this.detalle_ingreso = new HashSet<detalle_ingreso>();
        }
    
        public int idarticulo { get; set; }
        public string nombre { get; set; }
        public int idcategoria { get; set; }
        public string Codigo { get; set; }
        public string Imag_Url { get; set; }
        public string descripcion { get; set; }
        public Nullable<decimal> precioVenta { get; set; }
        public Nullable<decimal> precioCompra { get; set; }
        public Nullable<decimal> cantidad { get; set; }
        public Nullable<bool> estado { get; set; }
        public int idProveedor { get; set; }
        public string CodigoBarra { get; set; }
    
        public virtual categoria categoria { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<detalle_ingreso> detalle_ingreso { get; set; }
    }
}
