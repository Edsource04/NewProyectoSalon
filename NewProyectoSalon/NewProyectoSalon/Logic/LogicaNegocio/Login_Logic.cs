using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Data.GlobalRepocitory;
using Entity.Global_Entity;


namespace Logic.LogicaNegocio
{
   
    
   public class Login_Logic
    {
        private _LoginRepocitorio l = new _LoginRepocitorio();

        public Entity.Global_Entity.LoginEntity login( string usu,string pass)
        {
            var claveEncrip = Utility.Encrypt_Query(pass);
            var rep= l.Verificar(usu,claveEncrip);

            if (rep == null)
            {
                return null;
            } else
            {
             
                return rep;
            }
        }
    }
}
