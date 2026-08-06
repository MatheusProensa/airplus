package com.sulake.habbo.ui.widget.chooser.furni
{
   import com.sulake.habbo.ui.widget.chooser.ChooserItem;
   import com.sulake.habbo.utils.FurniId;
   import com.sulake.habbo.window.utils.tableview.ITableObject;
   import com.sulake.habbo.window.utils.tableview.TableCell;
   
   public class FurniChooserTableObject implements ITableObject
   {
      private var _chooserItem:ChooserItem;
      
      public function FurniChooserTableObject(param1:ChooserItem)
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
         return _chooserItem.category + "-" + _chooserItem.id;
      }
      
      public function getTableCell(param1:String) : TableCell
      {
         switch(param1)
         {
            case FurniView.COLUMN_FURNI_NAME:
               return new TableCell(TableCell.UnknownConstFromIlluminaChatBubbleMessage_Int_1,_chooserItem.name,false,true);
            case FurniView.COLUMN_FURNI_OWNER:
               if(_chooserItem.owner == null || FurniId.isBuilderClubId(_chooserItem.id) || FurniId.isTempId(_chooserItem.id))
               {
                  return new TableCell(TableCell.UnknownConstFromIlluminaChatBubbleMessage_Int_1,"-");
               }
               return new TableCell(TableCell.UnknownConstFromIlluminaChatBubbleMessage_Int_1,_chooserItem.owner,false,true);
               break;
            case FurniView.COLUMN_ID:
               return new TableCell(TableCell.UnknownConstFromIlluminaChatBubbleMessage_Int_1,_chooserItem.id + "",false,true);
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

