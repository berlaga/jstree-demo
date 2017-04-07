//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace TreeDemo.Data
{
    using System;
    using System.Collections.Generic;
    
    public partial class TreeItem
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public TreeItem()
        {
            this.TreeItem1 = new HashSet<TreeItem>();
        }
    
        public int Id { get; set; }
        public Nullable<int> ParentId { get; set; }
        public int TypeId { get; set; }
        public Nullable<int> StateId { get; set; }
        public string Name { get; set; }
        public string Icon { get; set; }
        public bool IsSelected { get; set; }
        public bool IsRoot { get; set; }
    
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<TreeItem> TreeItem1 { get; set; }
        public virtual TreeItem TreeItem2 { get; set; }
        public virtual TreeItemType TreeItemType { get; set; }
        public virtual TreeState TreeState { get; set; }
    }
}
