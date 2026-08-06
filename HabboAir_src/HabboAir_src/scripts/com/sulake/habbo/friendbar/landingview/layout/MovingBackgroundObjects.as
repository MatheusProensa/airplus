package com.sulake.habbo.friendbar.landingview.layout
{
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.core.runtime.IProfiler_1;
   import com.sulake.core.utils.Map;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.habbo.friendbar.landingview.HabboLandingView;
   import com.sulake.habbo.friendbar.landingview.layout.backgroundobjects.*;
   import flash.events.EventDispatcher;
   
   public class MovingBackgroundObjects implements IComponentInterfaceQueue, IProfiler_1
   {
      private static const MAX_OBJECTS:int = 20;
      
      private var _landingView:HabboLandingView;
      
      private var UnknownVarFromMovingBackgroundObjects_Array_1:Array = [];
      
      private var UnknownVarFromMovingBackgroundObjects_Map_1:Map = new Map();
      
      private var UnknownVarFromMovingBackgroundObjects_EventDispatcher_1:EventDispatcher = new EventDispatcher();
      
      private var _timingCode:String = "";
      
      public function MovingBackgroundObjects(param1:HabboLandingView)
      {
         super();
         _landingView = param1;
         initializeObjectTypeMapping();
      }
      
      private function initializeObjectTypeMapping() : void
      {
         UnknownVarFromMovingBackgroundObjects_Map_1.add("line",UnknownHabboFriendbarLandingviewLayoutBackgroundobjects1.CLASS_LINEAR);
         UnknownVarFromMovingBackgroundObjects_Map_1.add("spiral",UnknownHabboFriendbarLandingviewLayoutBackgroundobjects1.CLASS_SPIRAL);
         UnknownVarFromMovingBackgroundObjects_Map_1.add("animated",UnknownHabboFriendbarLandingviewLayoutBackgroundobjects1.CLASS_STATIC_ANIMATED);
         UnknownVarFromMovingBackgroundObjects_Map_1.add("randomwalk",UnknownHabboFriendbarLandingviewLayoutBackgroundobjects1.CLASS_RANDOM_WALK);
      }
      
      public function dispose() : void
      {
         _landingView = null;
         for each(var _loc1_ in UnknownVarFromMovingBackgroundObjects_Array_1)
         {
            _loc1_.dispose();
         }
         UnknownVarFromMovingBackgroundObjects_Array_1 = null;
         UnknownVarFromMovingBackgroundObjects_Map_1.reset();
         UnknownVarFromMovingBackgroundObjects_Map_1 = null;
         UnknownVarFromMovingBackgroundObjects_EventDispatcher_1 = null;
      }
      
      public function get disposed() : Boolean
      {
         return _landingView == null;
      }
      
      public function initialize(param1:IWindowController_1) : void
      {
         var _loc4_:int = 0;
         var _loc2_:String = null;
         var _loc3_:BackgroundObject = null;
         param1 = IWindowController_1(param1.findChildByName("moving_objects_container"));
         if(param1 == null)
         {
            return;
         }
         if(UnknownVarFromMovingBackgroundObjects_Array_1.length > 0)
         {
            return;
         }
         _loc4_ = 1;
         while(_loc4_ <= 20)
         {
            if(_timingCode == "")
            {
               _loc2_ = _landingView.getProperty("landing.view.bgobject." + _loc4_);
            }
            else
            {
               _loc2_ = _landingView.getProperty("landing.view." + _timingCode + ".bgobject." + _loc4_);
            }
            if(_loc2_ != "")
            {
               _loc3_ = getObjectByDataContent(_loc4_,_loc2_,param1);
               if(_loc3_ != null)
               {
                  UnknownVarFromMovingBackgroundObjects_Array_1.push(_loc3_);
               }
            }
            _loc4_++;
         }
      }
      
      public function update(param1:uint) : void
      {
         for each(var _loc2_ in UnknownVarFromMovingBackgroundObjects_Array_1)
         {
            _loc2_.update(param1);
         }
      }
      
      private function getObjectByDataContent(param1:int, param2:String, param3:IWindowController_1) : BackgroundObject
      {
         var _loc6_:String = null;
         var _loc5_:Class = null;
         var _loc4_:Array = param2.split(";");
         if(_loc4_.length >= 2)
         {
            _loc6_ = _loc4_[1];
            _loc5_ = UnknownVarFromMovingBackgroundObjects_Map_1.getValue(_loc6_);
            if(_loc5_ != null)
            {
               return new _loc5_(param1,param3,UnknownVarFromMovingBackgroundObjects_EventDispatcher_1,_landingView,param2);
            }
         }
         return null;
      }
      
      public function set timingCode(param1:String) : void
      {
         _timingCode = param1;
      }
   }
}

