package com.sulake.habbo.roomevents.wired_menu.tabs.tab_variable_overview
{
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.core.runtime.IProfiler_1;
   import com.sulake.core.utils.Map;
   import com.sulake.habbo.room.IRoomEngine_2;
   import com.sulake.habbo.room.events.RoomEngineObjectEvent;
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   import com.sulake.habbo.roomevents.wired_setup.RoomObjectHighLighter;
   import com.sulake.habbo.session.IUserData;
   import com.sulake.room.object.IRoomObject;
   import com.sulake.room.object.IRoomObjectController;
   import flash.filters.ColorMatrixFilter;
   import flash.filters.GlowFilter;
   import flash.utils.Dictionary;
   
   public class VariableHoldersHighlighter implements IComponentInterfaceQueue, IProfiler_1
   {
      private var _disposed:Boolean;
      
      private var _roomEvents:HabboUserDefinedRoomEvents;
      
      private var UnknownVarFromVariableHoldersHighlighter_Dictionary_1:Dictionary;
      
      private var UnknownVarFromVariableHoldersHighlighter_Dictionary_2:Dictionary;
      
      private var UnknownVarFromVariableHoldersHighlighter_Array_1:Array;
      
      private var UnknownVarFromVariableHoldersHighlighter_Vector_1:Vector.<VariableInfoBubbleView>;
      
      private var _assignedBubbles:Map;
      
      public function VariableHoldersHighlighter(param1:HabboUserDefinedRoomEvents)
      {
         super();
         _roomEvents = param1;
         UnknownVarFromVariableHoldersHighlighter_Dictionary_1 = new Dictionary();
         UnknownVarFromVariableHoldersHighlighter_Dictionary_2 = new Dictionary();
         UnknownVarFromVariableHoldersHighlighter_Vector_1 = new Vector.<VariableInfoBubbleView>();
         _assignedBubbles = new Map();
         var _loc2_:GlowFilter = new GlowFilter(12318714,1,4,4,4,1,true,false);
         var _loc3_:ColorMatrixFilter = new ColorMatrixFilter([0.9,0,0,0,0,0,1,0,0,40,0,0,1,0,80,0,0,0,0.85,0]);
         UnknownVarFromVariableHoldersHighlighter_Array_1 = [_loc3_,_loc2_];
         _roomEvents.roomEngine.events.addEventListener("REOE_REMOVED",onRoomObjectRemoved);
      }
      
      public function highlightObject(param1:int, param2:String) : void
      {
         var _loc4_:String = null;
         var _loc3_:Boolean = true;
         if(param1 in UnknownVarFromVariableHoldersHighlighter_Dictionary_1)
         {
            _loc4_ = UnknownVarFromVariableHoldersHighlighter_Dictionary_1[param1];
            if(_loc4_ == param2)
            {
               return;
            }
            _loc3_ = false;
         }
         var _loc5_:IRoomObject = getFurniRoomObject(param1);
         if(_loc5_ == null)
         {
            return;
         }
         setFurniObjectHighlightAndValue(_loc3_,_loc5_,param2);
         UnknownVarFromVariableHoldersHighlighter_Dictionary_1[param1] = param2;
      }
      
      public function highlightUser(param1:int, param2:String) : void
      {
         var _loc5_:String = null;
         var _loc4_:Boolean = true;
         if(param1 in UnknownVarFromVariableHoldersHighlighter_Dictionary_2)
         {
            _loc5_ = UnknownVarFromVariableHoldersHighlighter_Dictionary_2[param1];
            if(_loc5_ == param2)
            {
               return;
            }
            _loc4_ = false;
         }
         var _loc3_:IUserData = _roomEvents.roomSession.userDataManager.getUserDataByIndex(param1);
         if(_loc3_ == null)
         {
            return;
         }
         var _loc6_:IRoomObject = getUserRoomObject(param1);
         if(_loc6_ == null)
         {
            return;
         }
         if(_loc3_.type == 2)
         {
            setFurniObjectHighlightAndValue(_loc4_,_loc6_,param2);
         }
         else
         {
            setUserObjectHighlightAndValue(_loc4_,_loc6_,param2);
         }
         UnknownVarFromVariableHoldersHighlighter_Dictionary_2[param1] = param2;
      }
      
      public function removeRemovedHolders(param1:Dictionary, param2:Dictionary) : void
      {
         var _loc6_:int = 0;
         var _loc7_:IRoomObject = null;
         var _loc5_:int = 0;
         var _loc3_:IUserData = null;
         var _loc4_:Vector.<int> = new Vector.<int>();
         for(_loc6_ in UnknownVarFromVariableHoldersHighlighter_Dictionary_1)
         {
            if(!(_loc6_ in param1))
            {
               _loc7_ = getFurniRoomObject(_loc6_);
               if(_loc7_ != null)
               {
                  removeFurniObjectHighlightAndValue(_loc7_);
                  RoomObjectHighLighter.removeFiltersFromFurni(_loc7_,UnknownVarFromVariableHoldersHighlighter_Array_1);
               }
               _loc4_.push(_loc6_);
            }
         }
         for each(_loc6_ in _loc4_)
         {
            delete UnknownVarFromVariableHoldersHighlighter_Dictionary_1[_loc6_];
         }
         _loc4_ = new Vector.<int>();
         for(_loc5_ in UnknownVarFromVariableHoldersHighlighter_Dictionary_2)
         {
            if(!(_loc5_ in param2))
            {
               _loc7_ = getUserRoomObject(_loc5_);
               _loc3_ = _roomEvents.roomSession.userDataManager.getUserDataByIndex(_loc5_);
               if(_loc7_ != null && _loc3_ != null)
               {
                  if(_loc3_.type == 2)
                  {
                     removeFurniObjectHighlightAndValue(_loc7_);
                  }
                  else
                  {
                     removeUserObjectHighlightAndValue(_loc7_);
                  }
               }
               _loc4_.push(_loc5_);
            }
         }
         for each(_loc5_ in _loc4_)
         {
            delete UnknownVarFromVariableHoldersHighlighter_Dictionary_2[_loc5_];
         }
      }
      
      private function setFurniObjectHighlightAndValue(param1:Boolean, param2:IRoomObject, param3:String) : void
      {
         if(param1)
         {
            RoomObjectHighLighter.addFiltersToFurni(param2,UnknownVarFromVariableHoldersHighlighter_Array_1);
         }
         updateBubbleForObject(param2,param3);
      }
      
      private function setUserObjectHighlightAndValue(param1:Boolean, param2:IRoomObject, param3:String) : void
      {
         if(param1)
         {
            IRoomObjectController(param2).getModelController().setNumber("figure_highlight_variable_holder",1);
         }
         updateBubbleForObject(param2,param3,true);
      }
      
      private function onRoomObjectRemoved(param1:RoomEngineObjectEvent) : void
      {
         var _loc3_:int = 0;
         var _loc2_:VariableInfoBubbleView = null;
         _loc3_ = 0;
         while(_loc3_ < _assignedBubbles.length)
         {
            _loc2_ = _assignedBubbles.getWithIndex(_loc3_);
            if(_loc2_.objectId == param1.objectId && _loc2_.category == param1.category)
            {
               _assignedBubbles.remove(_assignedBubbles.getKey(_loc3_));
               _loc2_.setInactive();
               UnknownVarFromVariableHoldersHighlighter_Vector_1.push(_loc2_);
            }
            _loc3_ += 1;
         }
      }
      
      private function updateBubbleForObject(param1:IRoomObject, param2:String, param3:Boolean = false) : void
      {
         var _loc4_:VariableInfoBubbleView = _assignedBubbles.getValue(param1);
         if(param2 == null && _loc4_ != null)
         {
            recycleBubbleForObject(param1);
         }
         else if(param2 != null && _loc4_ != null)
         {
            _loc4_.updateValue(param2);
         }
         else if(param2 != null && _loc4_ == null)
         {
            reuseOrCreateBubble(param2,param1,param1.getId(),roomEngineServices.getRoomObjectCategory(param1.getType()),param3);
         }
      }
      
      private function get roomEngineServices() : IRoomEngine_2
      {
         return _roomEvents.roomEngine as IRoomEngine_2;
      }
      
      private function removeFurniObjectHighlightAndValue(param1:IRoomObject) : void
      {
         RoomObjectHighLighter.removeFiltersFromFurni(param1,UnknownVarFromVariableHoldersHighlighter_Array_1);
         recycleBubbleForObject(param1);
      }
      
      private function removeUserObjectHighlightAndValue(param1:IRoomObject) : void
      {
         IRoomObjectController(param1).getModelController().setNumber("figure_highlight_variable_holder",0);
         recycleBubbleForObject(param1);
      }
      
      private function recycleBubbleForObject(param1:IRoomObject) : void
      {
         var _loc2_:VariableInfoBubbleView = _assignedBubbles.remove(param1);
         if(_loc2_ != null)
         {
            _loc2_.setInactive();
            UnknownVarFromVariableHoldersHighlighter_Vector_1.push(_loc2_);
         }
      }
      
      private function reuseOrCreateBubble(param1:String, param2:IRoomObject, param3:int, param4:int, param5:Boolean) : VariableInfoBubbleView
      {
         var _loc6_:VariableInfoBubbleView = null;
         if(UnknownVarFromVariableHoldersHighlighter_Vector_1.length > 0)
         {
            _loc6_ = UnknownVarFromVariableHoldersHighlighter_Vector_1.pop();
         }
         else
         {
            _loc6_ = new VariableInfoBubbleView(_roomEvents);
         }
         _assignedBubbles.add(param2,_loc6_);
         _loc6_.setActive(param1,param3,param4,param5);
         return _loc6_;
      }
      
      public function clear() : void
      {
         var _loc1_:Dictionary = new Dictionary();
         removeRemovedHolders(_loc1_,_loc1_);
      }
      
      private function getFurniRoomObject(param1:int) : IRoomObject
      {
         if(param1 < 0)
         {
            param1 = -param1;
            return _roomEvents.roomEngine.getRoomObject(_roomEvents.roomId,param1,20);
         }
         return _roomEvents.roomEngine.getRoomObject(_roomEvents.roomId,param1,10);
      }
      
      private function getUserRoomObject(param1:int) : IRoomObject
      {
         return _roomEvents.roomEngine.getRoomObject(_roomEvents.roomId,param1,100);
      }
      
      public function update(param1:uint) : void
      {
         for each(var _loc2_ in _assignedBubbles)
         {
            _loc2_.update(param1);
         }
      }
      
      public function dispose() : void
      {
         var _loc1_:* = null;
         if(_disposed)
         {
            return;
         }
         clear();
         _roomEvents.roomEngine.events.removeEventListener("REOE_REMOVED",onRoomObjectRemoved);
         for each(_loc1_ in UnknownVarFromVariableHoldersHighlighter_Vector_1)
         {
            _loc1_.dispose();
         }
         for each(_loc1_ in _assignedBubbles.getValues())
         {
            _loc1_.dispose();
         }
         UnknownVarFromVariableHoldersHighlighter_Vector_1 = null;
         _assignedBubbles = null;
         UnknownVarFromVariableHoldersHighlighter_Dictionary_1 = null;
         UnknownVarFromVariableHoldersHighlighter_Dictionary_2 = null;
         _disposed = true;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
   }
}

