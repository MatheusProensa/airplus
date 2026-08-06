package com.sulake.habbo.roomevents
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredcontext.variables.WiredVariable;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredmenu.WiredAllVariablesDiffsEvent;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredmenu.WiredAllVariablesHashEvent;
   import com.sulake.habbo.communication.messages.outgoing.userdefinedroomevents.wiredmenu.WiredGetAllVariablesDiffsMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.userdefinedroomevents.wiredmenu.WiredGetAllVariablesHashMessageComposer;
   import com.sulake.habbo.communication.messages.parser.userdefinedroomevents.wiredmenu.WiredAllVariablesDiffsMessageParser;
   import flash.utils.Dictionary;
   import flash.utils.getTimer;
   
   public class WiredVariablesSynchronizer implements IComponentInterfaceQueue
   {
      private static var STATUS_IDLE:int = 0;
      
      private static var STATUS_AWAIT_HASH:int = 1;
      
      private static var STATUS_AWAIT_DIFFS:int = 2;
      
      private static var REQUEST_OFFSET:int = 800;
      
      private static var INVALIDATE_REQUEST_OFFSET:int = 4000;
      
      private var _disposed:Boolean;
      
      private var UnknownVarFromWiredVariablesSynchronizer_Number_1:Number = -1;
      
      private var _status:int = STATUS_IDLE;
      
      private var _allVariablesHash:int;
      
      private var UnknownVarFromWiredVariablesSynchronizer_Dictionary_1:Dictionary = null;
      
      private var _variableIdToHash:Dictionary = null;
      
      private var _listeners:Vector.<Function> = new Vector.<Function>();
      
      private var UnknownVarFromWiredVariablesSynchronizer_HabboUserDefinedRoomEvents_1:HabboUserDefinedRoomEvents;
      
      private var _messageEvents:Array;
      
      public function WiredVariablesSynchronizer(param1:HabboUserDefinedRoomEvents)
      {
         super();
         this.UnknownVarFromWiredVariablesSynchronizer_HabboUserDefinedRoomEvents_1 = param1;
         _messageEvents = [];
         _messageEvents.push(new WiredAllVariablesHashEvent(onAllVariablesHashEvent));
         _messageEvents.push(new WiredAllVariablesDiffsEvent(onAllVariablesDiffEvent));
         for each(var _loc2_ in _messageEvents)
         {
            UnknownVarFromWiredVariablesSynchronizer_HabboUserDefinedRoomEvents_1.communication.addHabboConnectionMessageEvent(_loc2_);
         }
      }
      
      public function getAllVariables(param1:Function, param2:Boolean = true, param3:int = 0) : Boolean
      {
         if(_status != STATUS_IDLE && UnknownVarFromWiredVariablesSynchronizer_Number_1 < getTimer() - INVALIDATE_REQUEST_OFFSET)
         {
            _status = STATUS_IDLE;
         }
         if(_status != STATUS_IDLE)
         {
            addListener(param1);
            return false;
         }
         if(UnknownVarFromWiredVariablesSynchronizer_Number_1 > getTimer() - REQUEST_OFFSET)
         {
            param1(sortedCachedVariables);
            return true;
         }
         if(!param2 && UnknownVarFromWiredVariablesSynchronizer_Dictionary_1 != null)
         {
            param1(sortedCachedVariables);
            return true;
         }
         UnknownVarFromWiredVariablesSynchronizer_Number_1 = getTimer();
         _status = STATUS_AWAIT_HASH;
         addListener(param1);
         if(param3 != 0)
         {
            onAllVariablesHash(param3);
         }
         else
         {
            UnknownVarFromWiredVariablesSynchronizer_HabboUserDefinedRoomEvents_1.send(new WiredGetAllVariablesHashMessageComposer());
         }
         return false;
      }
      
      public function getCachedVariableById(param1:String) : WiredVariable
      {
         return UnknownVarFromWiredVariablesSynchronizer_Dictionary_1[param1];
      }
      
      private function onAllVariablesHashEvent(param1:WiredAllVariablesHashEvent) : void
      {
         onAllVariablesHash(param1.getParser().allVariablesHash);
      }
      
      private function onAllVariablesHash(param1:int) : void
      {
         if(_status != STATUS_AWAIT_HASH)
         {
            return;
         }
         UnknownVarFromWiredVariablesSynchronizer_Number_1 = getTimer();
         if(param1 == _allVariablesHash)
         {
            updateListeners();
            _status = STATUS_IDLE;
         }
         else
         {
            _allVariablesHash = param1;
            _status = STATUS_AWAIT_DIFFS;
            UnknownVarFromWiredVariablesSynchronizer_HabboUserDefinedRoomEvents_1.send(new WiredGetAllVariablesDiffsMessageComposer(_variableIdToHash));
         }
      }
      
      private function onAllVariablesDiffEvent(param1:WiredAllVariablesDiffsEvent) : void
      {
         if(_status != STATUS_AWAIT_DIFFS)
         {
            return;
         }
         UnknownVarFromWiredVariablesSynchronizer_Number_1 = getTimer();
         var _loc2_:WiredAllVariablesDiffsMessageParser = param1.getParser();
         _allVariablesHash = _loc2_.allVariablesHash;
         if(UnknownVarFromWiredVariablesSynchronizer_Dictionary_1 == null)
         {
            UnknownVarFromWiredVariablesSynchronizer_Dictionary_1 = new Dictionary();
            _variableIdToHash = new Dictionary();
         }
         deleteVariablesInCache(_loc2_.removedVariables);
         updateVariablesInCache(_loc2_.addedOrUpdated);
         if(_loc2_.isLastChunk)
         {
            updateListeners();
            _status = STATUS_IDLE;
         }
      }
      
      private function deleteVariablesInCache(param1:Vector.<String>) : void
      {
         for each(var _loc2_ in param1)
         {
            if(_loc2_ in UnknownVarFromWiredVariablesSynchronizer_Dictionary_1)
            {
               delete UnknownVarFromWiredVariablesSynchronizer_Dictionary_1[_loc2_];
               delete _variableIdToHash[_loc2_];
            }
         }
      }
      
      private function updateVariablesInCache(param1:Dictionary) : void
      {
         var _loc3_:int = 0;
         for(var _loc2_ in param1)
         {
            _loc3_ = int(param1[_loc2_]);
            UnknownVarFromWiredVariablesSynchronizer_Dictionary_1[_loc2_.variableId] = _loc2_;
            _variableIdToHash[_loc2_.variableId] = _loc3_;
         }
      }
      
      private function get sortedCachedVariables() : Vector.<WiredVariable>
      {
         if(UnknownVarFromWiredVariablesSynchronizer_Dictionary_1 == null)
         {
            return new Vector.<WiredVariable>();
         }
         var _loc1_:Vector.<WiredVariable> = new Vector.<WiredVariable>();
         for each(var _loc2_ in UnknownVarFromWiredVariablesSynchronizer_Dictionary_1)
         {
            _loc1_.push(_loc2_);
         }
         Util.sortVariables(_loc1_);
         return _loc1_;
      }
      
      private function addListener(param1:Function) : void
      {
         if(_listeners.indexOf(param1) == -1)
         {
            _listeners.push(param1);
         }
      }
      
      public function removeListener(param1:Function) : void
      {
         var _loc2_:int = int(_listeners.indexOf(param1));
         if(_loc2_ != -1)
         {
            _listeners.removeAt(_loc2_);
         }
      }
      
      private function updateListeners() : void
      {
         var _loc1_:Vector.<WiredVariable> = sortedCachedVariables;
         for each(var _loc2_ in _listeners)
         {
            _loc2_(_loc1_);
         }
         _listeners.splice(0,_listeners.length);
      }
      
      public function clear() : void
      {
         _listeners = new Vector.<Function>();
         UnknownVarFromWiredVariablesSynchronizer_Dictionary_1 = null;
         _variableIdToHash = null;
         _allVariablesHash = 0;
         UnknownVarFromWiredVariablesSynchronizer_Number_1 = -1;
         _status = STATUS_IDLE;
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         _disposed = true;
         _listeners = null;
         UnknownVarFromWiredVariablesSynchronizer_Number_1 = -1;
         _status = STATUS_IDLE;
         _allVariablesHash = 0;
         UnknownVarFromWiredVariablesSynchronizer_Dictionary_1 = null;
         _variableIdToHash = null;
         for each(var _loc1_ in _messageEvents)
         {
            UnknownVarFromWiredVariablesSynchronizer_HabboUserDefinedRoomEvents_1.communication.removeHabboConnectionMessageEvent(_loc1_);
         }
         _messageEvents = null;
         UnknownVarFromWiredVariablesSynchronizer_HabboUserDefinedRoomEvents_1 = null;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
   }
}

