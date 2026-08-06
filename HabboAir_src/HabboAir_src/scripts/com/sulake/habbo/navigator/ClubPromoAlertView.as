package com.sulake.habbo.navigator
{
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IFrameController;
   import com.sulake.core.window.events.WindowMouseEvent;
   
   public class ClubPromoAlertView extends AlertView
   {
      private var _text:String;
      
      private var UnknownVarFromClubPromoAlertView_String_1:String;
      
      public function ClubPromoAlertView(param1:IHabboNavigator_2, param2:String, param3:String, param4:String)
      {
         super(param1,"nav_promo_alert",param2);
         _text = param3;
         UnknownVarFromClubPromoAlertView_String_1 = param4;
      }
      
      override internal function setupAlertWindow(param1:IFrameController) : void
      {
         var _loc4_:IWindowController_1 = param1.content;
         _loc4_.findChildByName("body_text").caption = _text;
         _loc4_.findChildByName("promo_text").caption = UnknownVarFromClubPromoAlertView_String_1;
         var _loc3_:IWindowModel = _loc4_.findChildByName("ok");
         if(_loc3_ != null)
         {
            _loc3_.addEventListener("WME_CLICK",onOk);
         }
         var _loc2_:IWindowModel = _loc4_.findChildByName("promo_container");
         if(_loc2_ != null)
         {
            _loc2_.addEventListener("WME_CLICK",onPromo);
         }
      }
      
      private function onOk(param1:WindowMouseEvent) : void
      {
         dispose();
      }
      
      private function onPromo(param1:WindowMouseEvent) : void
      {
         navigator.openCatalogClubPage("ClubPromoAlertView");
         dispose();
      }
   }
}

