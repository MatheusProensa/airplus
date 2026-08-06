package com.sulake.habbo.toolbar.offers
{
   import com.sulake.core.assets.IAssetLibraryCollection;
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.catalog.IHabboCatalog;
   import com.sulake.habbo.catalog.offers.IOfferCenter;
   import com.sulake.habbo.catalog.offers.IOfferExtension;
   import com.sulake.habbo.toolbar.HabboToolbar;
   import com.sulake.habbo.window.IHabboWindowManagerComponent;
   
   public class OfferExtension implements IOfferExtension, IComponentInterfaceQueue
   {
      private var _disposed:Boolean;
      
      private var _window:IWindowController_1;
      
      private var _toolbar:HabboToolbar;
      
      private var _offerCenter:IOfferCenter;
      
      private var UnknownVarFromOfferExtension_IItemListWindow_1:IItemListWindow;
      
      public function OfferExtension(param1:HabboToolbar, param2:IHabboWindowManagerComponent, param3:IAssetLibraryCollection, param4:IHabboCatalog)
      {
         super();
         _toolbar = param1;
         _window = param2.buildFromXML(param3.getAssetByName("offer_extension_xml").content as XML) as IWindowController_1;
         _window.procedure = windowProcedure;
         _window.visible = false;
         UnknownVarFromOfferExtension_IItemListWindow_1 = _window.findChildByName("list") as IItemListWindow;
         _offerCenter = param4.getOfferCenter(this);
         param1.extensionView.attachExtension("video_offers",window,8);
         refresh();
      }
      
      private function windowProcedure(param1:WindowEvent, param2:IWindowModel) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         switch(param2.name)
         {
            case "start_video":
               _offerCenter.showVideo();
               break;
            case "check_rewards":
               _offerCenter.showRewards();
         }
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         UnknownVarFromOfferExtension_IItemListWindow_1 = null;
         if(_window != null)
         {
            _window.dispose();
            _window = null;
         }
         _toolbar = null;
         _disposed = true;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function get window() : IWindowController_1
      {
         return _window;
      }
      
      public function indicateRewards() : void
      {
         if(_window != null)
         {
            _window.visible = true;
            _window.findChildByName("check_rewards").visible = true;
            refresh();
         }
      }
      
      public function indicateVideoAvailable(param1:Boolean) : void
      {
         var _loc2_:IWindowModel = null;
         if(_window != null)
         {
            _window.visible ||= param1;
            _loc2_ = _window.findChildByName("start_video");
            _loc2_.visible = param1;
            if(_offerCenter.showingVideo)
            {
               _loc2_.disable();
               _loc2_.color = 10066329;
            }
            else
            {
               _loc2_.enable();
               _loc2_.color = 12932417;
            }
            refresh();
         }
      }
      
      private function refresh() : void
      {
         UnknownVarFromOfferExtension_IItemListWindow_1.arrangeListItems();
         _window.visible = UnknownVarFromOfferExtension_IItemListWindow_1.getListItemAt(0).visible || UnknownVarFromOfferExtension_IItemListWindow_1.getListItemAt(1).visible;
         _toolbar.extensionView.refreshItemWindow();
      }
   }
}

