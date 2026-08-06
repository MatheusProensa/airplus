package com.sulake.habbo.friendbar.landingview.widget.elements
{
   import com.sulake.core.window.IWindowModel;
   import com.sulake.habbo.friendbar.landingview.HabboLandingView;
   import com.sulake.habbo.friendbar.landingview.widget.GenericWidget;
   
   public class GoToRoomButtonElementHandler extends AbstractButtonElementHandler
   {
      private var UnknownVarFromGoToRoomButtonElementHandler_Int_1:int;
      
      public function GoToRoomButtonElementHandler()
      {
         super();
      }
      
      override public function initialize(param1:HabboLandingView, param2:IWindowModel, param3:Array, param4:GenericWidget) : void
      {
         super.initialize(param1,param2,param3,param4);
         UnknownVarFromGoToRoomButtonElementHandler_Int_1 = int(param3[2]);
      }
      
      override protected function onClick() : void
      {
         landingView.navigator.goToPrivateRoom(UnknownVarFromGoToRoomButtonElementHandler_Int_1);
         landingView.tracking.trackGoogle("landingView","click_gotoroom");
      }
   }
}

