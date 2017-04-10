using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using System.Web.Http.ModelBinding;

using TreeDemo.Models;
using TreeDemo.Business;

namespace TreeDemo.Controllers
{
    public class TreeController : ApiController
    {
        // GET: api/Tree
        [HttpGet]
        public IEnumerable<TreeViewNode> Get()
        {
            TreeModelManager man = new TreeModelManager();

            return man.CreateNewModel();
        }

        // GET: api/Tree/5
        [HttpGet]
        public IEnumerable<TreeViewNode> Get(int id)
        {
            TreeModelManager man = new TreeModelManager();

            return man.LoadModel(id);
        }

        // POST: api/Tree
        [HttpPost]
        public void Post([FromBody] TreeDataResult data)
        {
            //TreeModelManager man = new TreeModelManager();
            //man.SaveModel(data);
        }

     
    }
}
