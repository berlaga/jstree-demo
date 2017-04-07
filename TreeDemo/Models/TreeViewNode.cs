﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace TreeDemo.Models
{
    public class TreeViewNode
    {
        public string id { get; set; }
        
        public string parent { get; set; }

        public string type { get; set; }

        public string text { get; set; }

        public string icon { get; set; }

    }
}