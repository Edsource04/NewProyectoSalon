using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Data.EF_GLOBAL;
using Entity.Global_Entity;

namespace Data.GlobalRepocitory
{
  public  class _LoginRepocitorio
    {
        public  LoginEntity Verificar(string usu, string cla)
        {
            var result = new LoginEntity();


            try
            {
                using (var context = new GLOBAL_BELLEZAEntities())
                {
                    result = context.wv_usuario_trabajador
                                 .Where( a => a.Usuario == usu && a.Clave==cla)
                                 .Select(a => new Entity.Global_Entity.LoginEntity
                                 {
                                     Usuario=a.Usuario,
                                     Clave=a.Clave,
                                     NombreCompleto=a.NombreCompleto,
                                     RolID=a.RolID 
                                 }).SingleOrDefault();
                }
            }


            catch (Exception e)
            {
                return result;
                throw new Exception(e.Message);
            }

            return result;
        }
    }
}
