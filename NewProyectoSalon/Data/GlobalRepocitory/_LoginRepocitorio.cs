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
        /// <summary>
        /// Pedro Van eiker
        /// Este metodo devuelve el Usuario
        /// que se esta logeando
        /// </summary>
        /// <param name="usu">usuario</param>
        /// <param name="cla">clave</param>
        /// <returns></returns>
        public LoginEntity Verificar(string usu, string cla)
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
        /// <summary>
        /// Pedro Van eiker
        /// Este metodo devuelve el RollID
        /// </summary>
        /// <param name="id">Resive este parametro</param>
        /// <returns>Devuelve un Roll</returns>
        public RollEntity CompareRoll(int id)
        {
            var result = new RollEntity();
             
            try
            {
                using (var context = new GLOBAL_BELLEZAEntities())
                {
                    result = context.ROLES
                                 .Where( a => a.id == id)
                                 .Select(a => new Entity.Global_Entity.RollEntity
                                 {
                                    id=a.id,
                                    Nombre=a.Nombre
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
