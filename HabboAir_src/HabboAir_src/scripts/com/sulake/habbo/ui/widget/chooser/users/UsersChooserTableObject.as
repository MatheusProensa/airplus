package com.sulake.habbo.ui.widget.chooser.users
{
   import com.sulake.habbo.ui.widget.chooser.ChooserItem;
   import com.sulake.habbo.window.utils.tableview.ITableObject;
   import com.sulake.habbo.window.utils.tableview.TableCell;
   
   public class UsersChooserTableObject implements ITableObject
   {
      private var _chooserItem:ChooserItem;
      
      public function UsersChooserTableObject(param1:ChooserItem)
      {
         super();
         _chooserItem = param1;
      }
      
      public function get chooserItem() : ChooserItem
      {
         return _chooserItem;
      }
      
      public function get identifier() : String
      {
         return _chooserItem.type + "-" + _chooserItem.id;
      }
      
      public function getTableCell(param1:String) : TableCell
      {
         switch(param1)
         {
            case UsersView.COLUMN_USER_NAME:
               return new TableCell(TableCell.UnknownConstFromIlluminaChatBubbleMessage_Int_1,_chooserItem.name,false,true);
            case UsersView.COLUMN_TYPE:
               return new TableCell(TableCell.UnknownConstFromIlluminaChatBubbleMessage_Int_1,"${new_user_chooser.usertype." + _chooserItem.type + "}");
            default:
               return null;
         }
      }
      
      public function isPropertyUpdated(param1:String, param2:Object) : Boolean
      {
         return false;
      }
      
      public function isUpdated(param1:Object) : Boolean
      {
         return false;
      }
   }
}

