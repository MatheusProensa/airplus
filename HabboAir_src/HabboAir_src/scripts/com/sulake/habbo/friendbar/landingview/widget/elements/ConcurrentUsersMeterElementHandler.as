package com.sulake.habbo.friendbar.landingview.widget.elements
{
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.habbo.communication.messages.incoming.quest.ConcurrentUsersGoalProgressMessageEvent;
   import com.sulake.habbo.friendbar.landingview.HabboLandingView;
   import com.sulake.habbo.friendbar.landingview.interfaces.elements.IElementHandler;
   import com.sulake.habbo.friendbar.landingview.interfaces.elements.UnknownIHabboFriendbarLandingviewInterfacesElements1;
   import com.sulake.habbo.friendbar.landingview.widget.GenericWidget;
   
   public class ConcurrentUsersMeterElementHandler implements IElementHandler, UnknownIHabboFriendbarLandingviewInterfacesElements1
   {
      private var UnknownVarFromConcurrentUsersMeterElementHandler_IStaticBitmapWrapperWindow_1:IStaticBitmapWrapperWindow;
      
      private var UnknownVarFromConcurrentUsersMeterElementHandler_Int_1:int;
      
      private var UnknownVarFromConcurrentUsersMeterElementHandler_Int_2:int;
      
      private var UnknownVarFromConcurrentUsersMeterElementHandler_Int_3:int;
      
      public function ConcurrentUsersMeterElementHandler()
      {
         super();
      }
      
      public function initialize(param1:HabboLandingView, param2:IWindowModel, param3:Array, param4:GenericWidget) : void
      {
         UnknownVarFromConcurrentUsersMeterElementHandler_IStaticBitmapWrapperWindow_1 = IStaticBitmapWrapperWindow(param2);
         var _loc5_:String = param3[1];
         UnknownVarFromConcurrentUsersMeterElementHandler_IStaticBitmapWrapperWindow_1.assetUri = _loc5_;
         UnknownVarFromConcurrentUsersMeterElementHandler_IStaticBitmapWrapperWindow_1.x = param3.length > 2 ? int(param3[2]) : 0;
         UnknownVarFromConcurrentUsersMeterElementHandler_IStaticBitmapWrapperWindow_1.y = param3.length > 3 ? int(param3[3]) : 0;
         Logger.log("Init Concurrent users meter: " + _loc5_);
         param1.communicationManager.addHabboConnectionMessageEvent(new ConcurrentUsersGoalProgressMessageEvent(onConcurrentUsersGoalProgress));
      }
      
      public function refresh() : void
      {
      }
      
      public function isFloating(param1:Boolean) : Boolean
      {
         return true;
      }
      
      private function onConcurrentUsersGoalProgress(param1:ConcurrentUsersGoalProgressMessageEvent) : void
      {
         UnknownVarFromConcurrentUsersMeterElementHandler_Int_1 = param1.getParser().state;
         UnknownVarFromConcurrentUsersMeterElementHandler_Int_2 = param1.getParser().userCount;
         UnknownVarFromConcurrentUsersMeterElementHandler_Int_3 = param1.getParser().userCountGoal;
         var _loc3_:int = UnknownVarFromConcurrentUsersMeterElementHandler_Int_2 / UnknownVarFromConcurrentUsersMeterElementHandler_Int_3 * 100;
         _loc3_ = Math.max(20,Math.min(100,_loc3_));
         _loc3_ = Math.floor(_loc3_ / 10) * 10;
         var _loc2_:String = "challenge_meter_" + _loc3_;
         UnknownVarFromConcurrentUsersMeterElementHandler_IStaticBitmapWrapperWindow_1.assetUri = "${image.library.url}reception/" + _loc2_ + ".png";
         Logger.log("Updating meter: " + _loc2_);
      }
   }
}

