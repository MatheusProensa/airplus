package com.sulake.habbo.catalog.viewer.widgets
{
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.components.UnknownICoreWindowComponents4;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.communication.messages.outgoing.users.GetGuildCreationInfoMessageComposer;
   import com.sulake.habbo.tracking.HabboTracking;
   
   public class BuyGuildWidget extends CatalogWidget implements ICatalogWidget
   {
      private var _button:UnknownICoreWindowComponents4;
      
      public function BuyGuildWidget(param1:IWindowController_1)
      {
         super(param1);
         if(_button)
         {
            _button.removeEventListener("WME_CLICK",onButtonClicked);
         }
      }
      
      override public function init() : Boolean
      {
         if(!super.init())
         {
            return false;
         }
         _button = window.findChildByName("start_guild_purchase") as UnknownICoreWindowComponents4;
         _button.addEventListener("WME_CLICK",onButtonClicked);
         return true;
      }
      
      private function onButtonClicked(param1:WindowMouseEvent) : void
      {
         if(HabboTracking.getInstance() != null)
         {
            HabboTracking.getInstance().trackGoogle("groupPurchase","catalogBuyClicked");
         }
         page.viewer.catalog.connection.send(new GetGuildCreationInfoMessageComposer());
         page.viewer.catalog.toggleCatalog("NORMAL");
      }
   }
}

