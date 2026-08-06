package com.sulake.habbo.roomevents.wired_menu.variables_management.overview
{
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredcontext.variables.WiredVariable;
   import com.sulake.habbo.communication.messages.outgoing.userdefinedroomevents.wiredmenu.variables_management.WiredGetUserPermanentVariablesComposer;
   import com.sulake.habbo.communication.messages.outgoing.users.GetExtendedProfileMessageComposer;
   import com.sulake.habbo.communication.messages.parser.userdefinedroomevents.wiredmenu.variables_management.WiredUserVariablesElement;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   import com.sulake.habbo.roomevents.wired_menu.tabs.tab_inspection.VariableValueTableObject;
   import com.sulake.habbo.window.utils.tableview.ITableObject;
   import com.sulake.habbo.window.utils.tableview.TableCell;
   
   public class VariableManagementOverviewTableObject implements ITableObject
   {
      private var UnknownVarFromVariableManagementOverviewTableObject_VariableManagementOverviewController_1:VariableManagementOverviewController;
      
      private var _element:WiredUserVariablesElement;
      
      private var _variable:WiredVariable;
      
      public function VariableManagementOverviewTableObject(param1:VariableManagementOverviewController, param2:WiredUserVariablesElement, param3:WiredVariable)
      {
         super();
         UnknownVarFromVariableManagementOverviewTableObject_VariableManagementOverviewController_1 = param1;
         _element = param2;
         _variable = param3;
      }
      
      public function get identifier() : String
      {
         return _element.entityType + "-" + _element.entityId;
      }
      
      public function getTableCell(param1:String) : TableCell
      {
         switch(param1)
         {
            case "usertype":
               return new TableCell(TableCell.UnknownConstFromIlluminaChatBubbleMessage_Int_1,localize("wiredfurni.params.usertype." + _element.entityType));
            case "name":
               if(_element.entityType == 1)
               {
                  return new TableCell(TableCell.UnknownVarFromTableCell_Int_1,_element.entityName,false,true,null,onClickUsername);
               }
               return new TableCell(TableCell.UnknownConstFromIlluminaChatBubbleMessage_Int_1,_element.entityName,false,true);
               break;
            case "creation_time":
               return new TableCell(TableCell.UnknownConstFromIlluminaChatBubbleMessage_Int_1,_element.storage.creationTimeStr,false,true);
            case "last_update_time":
               return new TableCell(TableCell.UnknownConstFromIlluminaChatBubbleMessage_Int_1,_element.storage.lastUpdateTimeStr,false,true);
            case "value":
               return VariableValueTableObject.createVariableValueCell(_variable,_element.storage.value,UnknownVarFromVariableManagementOverviewTableObject_VariableManagementOverviewController_1.roomEvents,false,false);
            case "manage":
               return new TableCell(TableCell.UnknownVarFromTableCell_Int_1,localize("wiredmenu.variable_management.manage"),false,false,null,onClickManage);
            default:
               return null;
         }
      }
      
      private function onClickUsername() : void
      {
         UnknownVarFromVariableManagementOverviewTableObject_VariableManagementOverviewController_1.send(new GetExtendedProfileMessageComposer(_element.entityId,true));
      }
      
      private function onClickManage() : void
      {
         UnknownVarFromVariableManagementOverviewTableObject_VariableManagementOverviewController_1.send(new WiredGetUserPermanentVariablesComposer(_element.entityType,_element.entityId));
      }
      
      private function localize(param1:String) : String
      {
         return localization.getLocalization(param1);
      }
      
      private function get localization() : IHabboLocalizationManager
      {
         return UnknownVarFromVariableManagementOverviewTableObject_VariableManagementOverviewController_1.localizationManager;
      }
      
      public function get element() : WiredUserVariablesElement
      {
         return _element;
      }
      
      public function get variable() : WiredVariable
      {
         return _variable;
      }
      
      public function isPropertyUpdated(param1:String, param2:Object) : Boolean
      {
         var _loc3_:VariableManagementOverviewTableObject = param2 as VariableManagementOverviewTableObject;
         if(param1 == "creation_time")
         {
            return _element.storage.creationTime != _loc3_.element.storage.creationTime;
         }
         if(param1 == "last_update_time")
         {
            return _element.storage.lastUpdateTime != _loc3_.element.storage.lastUpdateTime;
         }
         if(param1 == "value")
         {
            return _element.storage.value != _loc3_.element.storage.value || _variable.hasValue != _loc3_.variable.hasValue;
         }
         return false;
      }
      
      public function isUpdated(param1:Object) : Boolean
      {
         return isPropertyUpdated("creation_time",param1) || isPropertyUpdated("last_update_time",param1) || isPropertyUpdated("value",param1);
      }
   }
}

