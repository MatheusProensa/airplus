package com.sulake.habbo.communication.messages.parser.userdefinedroomevents.wiredmenu.variables_management
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   public class WiredUserVariablesElement
   {
      private var _entityType:int;
      
      private var _entityId:int;
      
      private var _entityName:String;
      
      private var _storage:WiredVariableStorageParameter;
      
      public function WiredUserVariablesElement(param1:IMessageDataWrapper)
      {
         super();
         _entityType = param1.readInteger();
         _entityId = param1.readInteger();
         _entityName = param1.readString();
         _storage = new WiredVariableStorageParameter(param1);
      }
      
      public function get entityType() : int
      {
         return _entityType;
      }
      
      public function get entityId() : int
      {
         return _entityId;
      }
      
      public function get entityName() : String
      {
         return _entityName;
      }
      
      public function get storage() : WiredVariableStorageParameter
      {
         return _storage;
      }
   }
}

