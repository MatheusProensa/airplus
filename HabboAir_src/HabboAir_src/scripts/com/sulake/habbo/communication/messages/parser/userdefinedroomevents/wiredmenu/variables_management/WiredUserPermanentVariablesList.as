package com.sulake.habbo.communication.messages.parser.userdefinedroomevents.wiredmenu.variables_management
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import flash.utils.Dictionary;
   
   public class WiredUserPermanentVariablesList
   {
      private var _entityType:int;
      
      private var _entityId:int;
      
      private var _entityName:String;
      
      private var _entityFigure:String;
      
      private var _ownerId:int;
      
      private var _ownerName:String;
      
      private var _ownerFigure:String;
      
      private var _variableStorage:Vector.<WiredVariableStorageParameter>;
      
      private var _variableIds:Dictionary;
      
      public function WiredUserPermanentVariablesList(param1:IMessageDataWrapper)
      {
         var _loc3_:* = undefined;
         var _loc4_:WiredVariableStorageParameter = null;
         super();
         _entityType = param1.readInteger();
         _entityId = param1.readInteger();
         _entityName = param1.readString();
         _entityFigure = param1.readString();
         if(_entityType != 1)
         {
            _ownerId = param1.readInteger();
            _ownerName = param1.readString();
            _ownerFigure = param1.readString();
         }
         _variableStorage = new Vector.<WiredVariableStorageParameter>();
         _variableIds = new Dictionary();
         var _loc2_:int = param1.readInteger();
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = new WiredVariableStorageParameter(param1,true);
            _variableStorage.push(_loc4_);
            _variableIds[_loc4_.variableId] = true;
            _loc3_++;
         }
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
      
      public function get entityFigure() : String
      {
         return _entityFigure;
      }
      
      public function get ownerId() : int
      {
         return _ownerId;
      }
      
      public function get ownerName() : String
      {
         return _ownerName;
      }
      
      public function get ownerFigure() : String
      {
         return _ownerFigure;
      }
      
      public function get variableStorage() : Vector.<WiredVariableStorageParameter>
      {
         return _variableStorage;
      }
      
      public function get variableIds() : Dictionary
      {
         return _variableIds;
      }
   }
}

