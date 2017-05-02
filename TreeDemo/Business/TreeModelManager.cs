using System;
using System.Collections.Generic;
using System.Collections;
using System.Linq;
using System.Web;
using System.IO;

using Newtonsoft.Json.Linq;
using Newtonsoft.Json;

using TreeDemo.Data;
using TreeDemo.Models;


namespace TreeDemo.Business
{
    public class TreeModelManager
    {
        //ctor
        public TreeModelManager() { }

        public JArray CreateNewModelFromFile()
        {
            using (StreamReader sr = new StreamReader(System.Web.Hosting.HostingEnvironment.MapPath("~/App_Data/data.json")))
            {
                JArray jsonObj = JArray.Parse(sr.ReadToEnd());


                return jsonObj;

                //foreach (var item in jsonObj)
                //{
                //    TreeNode n = (TreeNode)JsonConvert.DeserializeObject(item.ToString(), typeof(TreeNode));
                //}
            }

            //List<TreeViewNode> treeNodes = new List<TreeViewNode>();

            //return treeNodes;
        }

        public JToken LoadTypes()
        {
            using (StreamReader sr = new StreamReader(System.Web.Hosting.HostingEnvironment.MapPath("~/App_Data/types.json")))
            {
                JToken types = JToken.Parse(sr.ReadToEnd());

                return types;
            }


        }



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
                            li_attr = new { @class = SetLiCSSClass(item) },
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


        private string SetLiCSSClass(TreeItem node)
        {
            if ((node.TypeId == 1) || (node.TypeId == 2) || (node.TypeId == 3))
            {
                //root node
                return string.Empty;
            }
            else if (node.Name == "Miniature Schnauzer")
                return "node-added node-child";
            else
                return "node-child";
        }

    }
}