using System;
using System.Collections.Generic;
using System.Collections;
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
                    treeNodes.Add(
                        new TreeViewNode() { id = item.Id.ToString(), 
                            parent = item.ParentId.HasValue ? item.ParentId.Value.ToString() : "#" , 
                            type = item.TypeId.ToString(), 
                            icon= string.Empty, 
                            text = item.Name,
                                             li_attr = item.Name == "Miniature Schnauzer" ? new { @class = "node-added" } : new { @class = "" },
                            data = new TreeViewNodeCustomData() { IsRoot = item.IsRoot, IsSelected= item.IsSelected }
                        });
                }


                return treeNodes;

            }
        }

        public List<TreeViewNode> LoadModel(int modelId)
        {
            return null;
        }
        
        public void SaveModel(TreeDataResult result)
        {
            //using (var context = new treeModelEntities())
            //{
            //    TreeState newState = new TreeState();
            //    newState.Name = result.StateName;

            //    context.TreeStates.Add(newState);

            //    foreach (var item in result.NodeList)
            //    {
            //        TreeItem newTreeItem = new TreeItem();

                   
            //        context.TreeItems.Add(newTreeItem);
            //    }
                
            //}

        }

    }
}