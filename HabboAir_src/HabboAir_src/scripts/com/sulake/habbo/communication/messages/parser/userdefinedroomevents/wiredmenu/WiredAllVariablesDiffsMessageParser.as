package com.sulake.habbo.communication.messages.parser.userdefinedroomevents.wiredmenu
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredcontext.variables.WiredVariable;
   import flash.utils.Dictionary;
   
   public class WiredAllVariablesDiffsMessageParser implements IMessageParser
   {
      private var _allVariablesHash:int;
      
      private var _isLastChunk:Boolean;
      
      private var _removedVariables:Vector.<String>;
      
      private var _addedOrUpdated:Dictionary;
      
      public function WiredAllVariablesDiffsMessageParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         _allVariablesHash = 0;
         _isLastChunk = false;
         _removedVariables = null;
         _addedOrUpdated = null;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc4_:WiredVariable = null;
         _allVariablesHash = param1.readInteger();
         _isLastChunk = param1.readBoolean();
         var _loc2_:int = param1.readInteger();
         _removedVariables = new Vector.<String>();
         _loc5_ = 0;
         while(_loc5_ < _loc2_)
         {
            _removedVariables.push(param1.readString());
            _loc5_++;
         }
         var _loc3_:int = param1.readInteger();
         _addedOrUpdated = new Dictionary();
         _loc5_ = 0;
         while(_loc5_ < _loc3_)
         {
            _loc6_ = param1.readInteger();
            _loc4_ = new WiredVariable(param1);
            _addedOrUpdated[_loc4_] = _loc6_;
            _loc5_++;
         }
         return true;
      }
      
      public function get isLastChunk() : Boolean
      {
         return _isLastChunk;
      }
      
      public function get removedVariables() : Vector.<String>
      {
         return _removedVariables;
      }
      
      public function get addedOrUpdated() : Dictionary
      {
         return _addedOrUpdated;
      }
      
      public function get allVariablesHash() : int
      {
         return _allVariablesHash;
      }
   }
}

