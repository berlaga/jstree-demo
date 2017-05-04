using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;

using TreeDemo.Data;
using TreeDemo.Models;

namespace TreeDemo.Controllers
{
    public class AutocompleteController : ApiController
    {
        // GET: api/Autocomplete
        public IEnumerable<string> Get()
        {
            return new string[] { "value1", "value2" };
        }

        // GET: api/Autocomplete/5
        [HttpGet]
        public List<AutocompleteResult> Get(string term)
        {
            using (var context = new treeModelEntities ())
            {
                var result = from r in context.DisclosureItemCategories
                             where r.DisclosureItemCategory1.Contains(term)
                             select new { label = r.DisclosureItemCategory1, value = r.DisclosureItemCategoryId };

                List<AutocompleteResult> list = new List<AutocompleteResult>();

                foreach (var item in  result.ToList())
                {
                    AutocompleteResult r = new AutocompleteResult() { value = item.value.ToString(), label = item.label.ToString() };

                    list.Add(r);
                }

                return list;
            }

        }

        // POST: api/Autocomplete
        public void Post([FromBody]string value)
        {
        }

        // PUT: api/Autocomplete/5
        public void Put(int id, [FromBody]string value)
        {
        }

        // DELETE: api/Autocomplete/5
        public void Delete(int id)
        {
        }
    }
}
