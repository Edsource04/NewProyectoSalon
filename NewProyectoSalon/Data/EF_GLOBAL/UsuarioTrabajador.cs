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
    
    public partial class UsuarioTrabajador
    {
        public int id { get; set; }
        public Nullable<int> id_trabajador { get; set; }
        public Nullable<int> id_usuario { get; set; }
        public Nullable<System.DateTime> fecha_asignacion { get; set; }
        public Nullable<System.DateTime> fecha_deasinacion { get; set; }
        public Nullable<bool> status_assignacion { get; set; }
        public string usuarioAdiciona { get; set; }
        public string usuarioModifica { get; set; }
        public Nullable<System.DateTime> fechaAdiciona { get; set; }
        public Nullable<System.DateTime> fechaModifica { get; set; }
    }
}
