using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Linq;
using System.Linq.Expressions;

namespace Data.Repocitorio
{
   public class BaseRepocitory
    {
        public interface IGenericRepository<T> where T : class
        {

            IQueryable<T> GetAll();
            IQueryable<T> Find(Expression<Func<T, bool>> predicate);
            void Add(T entity);
            void Delete(T entity);
            void Edit(T entity);
            void Save();

        }
    }
}
