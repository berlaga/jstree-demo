using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

using TreeDemo.Data;
using TreeDemo.Models;


namespace TreeDemo.Business
{
    public class TreeModelManager
    {
        //ctor
        public TreeModelManager() { }

        public List<TreeViewNode> CreateNewModel()
        {
            using (var context = new treeModelEntities ())
            {
                var result = from x in context.TreeItems
                             where !x.StateId.HasValue
                             select x;

                List<TreeViewNode> treeNodes = new List<TreeViewNode>();

                foreach (var item in result.ToList())
                {
                    treeNodes.Add(new TreeViewNode() { id = item.Id.ToString(), parent = item.ParentId.HasValue ? item.ParentId.Value.ToString() : "#" , type = item.TypeId.ToString(), icon= string.Empty, text = item.Name });
                }


                return treeNodes;

            }
        }

        public List<TreeViewNode> LoadModel(int modelId)
        {
            return null;
        }
        
        public void SaveModel(List<TreeDataResult> treeNodes)
        {

        }

    }
}