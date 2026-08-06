package com.sulake.habbo.friendbar.landingview.widget.elements
{
   import com.sulake.core.window.IWindowModel;
   import com.sulake.habbo.friendbar.landingview.HabboLandingView;
   import com.sulake.habbo.friendbar.landingview.widget.GenericWidget;
   
   public class PromotedRoomButtonElementHandler extends AbstractButtonElementHandler
   {
      private var _categoryCode:String;
      
      public function PromotedRoomButtonElementHandler()
      {
         super();
      }
      
      override protected function onClick() : void
      {
         landingView.goToRoom(_categoryCode);
         landingView.tracking.trackGoogle("landingView","click_promotedroom" + _categoryCode);
      }
      
      override public function initialize(param1:HabboLandingView, param2:IWindowModel, param3:Array, param4:GenericWidget) : void
      {
         super.initialize(param1,param2,param3,param4);
         if(param3.length > 1)
         {
            _categoryCode = param3[2];
         }
      }
   }
}

