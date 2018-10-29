﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SistemaAdministracionSalonBelleza
{
  public  class Seccion
    {
        public string Usuario { get; set; }
        
        public string nombreCompleto { get; set; }
        public int IdTrabajador { get; set; }
        public int RollId { get; set; }

        private static Seccion _user = null;

        private Seccion() { }

        public static Seccion Instance
        {
            get
            {
                if (_user == null)
                    _user = new Seccion();

                return _user;
            }

        }
    }
}
