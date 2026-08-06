package com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.contracts.itemtable
{
   import com.sulake.habbo.communication.messages.parser.userdefinedroomevents.wiredtrading.chests.storage.ChestItemType;
   import com.sulake.habbo.window.utils.tableview.ITableObject;
   import com.sulake.habbo.window.utils.tableview.TableCell;
   
   public class ItemTypeTableObject implements ITableObject
   {
      private var _chestItemType:ChestItemType;
      
      private var _localizedName:String;
      
      private var UnknownVarFromItemTypeTableObject_String_1:String;
      
      private var _displayCode:String;
      
      public function ItemTypeTableObject(param1:ChestItemType, param2:String, param3:String)
      {
         super();
         this._chestItemType = param1;
         this._localizedName = param2;
         this._displayCode = param3;
         this.UnknownVarFromItemTypeTableObject_String_1 = param2.toLowerCase();
      }
      
      public function get identifier() : String
      {
         return (_chestItemType.isWallItem ? "1-" : "0-") + _displayCode;
      }
      
      public function getTableCell(param1:String) : TableCell
      {
         var _loc2_:String = null;
         switch(param1)
         {
            case "furni_name":
               return new TableCell(TableCell.UnknownConstFromIlluminaChatBubbleMessage_Int_1,_localizedName,false,true);
            case "furni_code":
               return new TableCell(TableCell.UnknownConstFromIlluminaChatBubbleMessage_Int_1,_displayCode,false,true);
            case "furni_type":
               _loc2_ = _chestItemType.isWallItem ? "${inventory.filter.placement.wall}" : "${inventory.filter.placement.floor}";
               return new TableCell(TableCell.UnknownConstFromIlluminaChatBubbleMessage_Int_1,_loc2_);
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
      
      public function get chestItemType() : ChestItemType
      {
         return _chestItemType;
      }
      
      public function get localizedName() : String
      {
         return _localizedName;
      }
      
      public function get displayCode() : String
      {
         return _displayCode;
      }
      
      public function matchesSubstring(param1:String) : Boolean
      {
         return UnknownVarFromItemTypeTableObject_String_1.indexOf(param1) != -1 || _displayCode.indexOf(param1) != -1;
      }
   }
}

