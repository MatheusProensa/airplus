package com.sulake.habbo.navigator.view
{
   import com.sulake.core.runtime.IProfiler_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.IRegionWindow;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.components.UnknownICoreWindowComponents6;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.navigator.HabboNewNavigator;
   import flash.utils.getTimer;
   
   public class LiftView implements IProfiler_1
   {
      private static const AUTO_CYCLE_TIMEOUT_MS:uint = 8000;
      
      private var _navigator:HabboNewNavigator;
      
      private var UnknownVarFromLiftView_UnknownICoreWindowComponents6_1:UnknownICoreWindowComponents6;
      
      private var UnknownVarFromLiftView_IItemListWindow_1:IItemListWindow;
      
      private var UnknownVarFromLiftView_IRegionWindow_1:IRegionWindow;
      
      private var UnknownVarFromLiftView_Int_1:int = -1;
      
      private var UnknownVarFromLiftView_Uint_1:uint = getTimer();
      
      public function LiftView(param1:HabboNewNavigator)
      {
         super();
         _navigator = param1;
         _navigator.registerUpdateReceiver(this,1000);
      }
      
      public function dispose() : void
      {
         _navigator.removeUpdateReceiver(this);
         _navigator = null;
      }
      
      public function get disposed() : Boolean
      {
         return _navigator == null;
      }
      
      public function set pagerIconTemplate(param1:IRegionWindow) : void
      {
         UnknownVarFromLiftView_IRegionWindow_1 = param1;
      }
      
      public function set borderWindow(param1:UnknownICoreWindowComponents6) : void
      {
         UnknownVarFromLiftView_UnknownICoreWindowComponents6_1 = param1;
         UnknownVarFromLiftView_IItemListWindow_1 = IItemListWindow(UnknownVarFromLiftView_UnknownICoreWindowComponents6_1.findChildByName("pager_itemlist"));
         IRegionWindow(UnknownVarFromLiftView_UnknownICoreWindowComponents6_1.findChildByName("room_image_click_region")).procedure = goToRoomRegionProcedure;
      }
      
      public function refresh(param1:Boolean = true) : void
      {
         var _loc2_:int = 0;
         UnknownVarFromLiftView_IItemListWindow_1.destroyListItems();
         UnknownVarFromLiftView_Int_1 = param1 ? 0 : UnknownVarFromLiftView_Int_1;
         _loc2_ = 0;
         while(_loc2_ < _navigator.liftDataContainer.liftedRooms.length)
         {
            UnknownVarFromLiftView_IItemListWindow_1.addListItem(UnknownVarFromLiftView_IRegionWindow_1.clone());
            _loc2_++;
         }
         setPagerToSelectedPage();
         drawSelectedPage();
      }
      
      private function setPagerToSelectedPage() : void
      {
         var _loc1_:int = 0;
         var _loc2_:IRegionWindow = null;
         _loc1_ = 0;
         while(_loc1_ < UnknownVarFromLiftView_IItemListWindow_1.numListItems)
         {
            _loc2_ = IRegionWindow(UnknownVarFromLiftView_IItemListWindow_1.getListItemAt(_loc1_));
            IStaticBitmapWrapperWindow(_loc2_.findChildByName("icon")).assetUri = _loc1_ == UnknownVarFromLiftView_Int_1 ? "progress_disk_flat_on" : "progress_disk_flat_off";
            _loc2_.id = _loc1_;
            _loc2_.procedure = pagerPageProcedure;
            _loc1_++;
         }
      }
      
      private function drawSelectedPage() : void
      {
         setPagerToSelectedPage();
         IStaticBitmapWrapperWindow(UnknownVarFromLiftView_UnknownICoreWindowComponents6_1.findChildByName("room_image")).assetUri = _navigator.liftDataContainer.getUrlForLiftImageAtIndex(UnknownVarFromLiftView_Int_1);
         if(UnknownVarFromLiftView_Int_1 < _navigator.liftDataContainer.liftedRooms.length)
         {
            UnknownVarFromLiftView_UnknownICoreWindowComponents6_1.findChildByName("caption_text").caption = _navigator.liftDataContainer.liftedRooms[UnknownVarFromLiftView_Int_1].caption;
         }
      }
      
      private function autoCycleToNextPage() : void
      {
         UnknownVarFromLiftView_Int_1++;
         if(UnknownVarFromLiftView_Int_1 > _navigator.liftDataContainer.liftedRooms.length - 1)
         {
            UnknownVarFromLiftView_Int_1 = 0;
         }
         refresh(false);
      }
      
      public function update(param1:uint) : void
      {
         var _loc2_:uint = uint(getTimer());
         if(UnknownVarFromLiftView_Uint_1 + 8000 < _loc2_)
         {
            autoCycleToNextPage();
            UnknownVarFromLiftView_Uint_1 = _loc2_;
         }
      }
      
      private function pagerPageProcedure(param1:WindowEvent, param2:IWindowModel) : void
      {
         if(param1.type == "WME_CLICK")
         {
            if(param2.id != UnknownVarFromLiftView_Int_1)
            {
               UnknownVarFromLiftView_Int_1 = param2.id;
               drawSelectedPage();
               UnknownVarFromLiftView_Uint_1 = getTimer();
               _navigator.trackEventLog("browse.promotion","Promotion","",UnknownVarFromLiftView_Int_1);
            }
         }
      }
      
      private function goToRoomRegionProcedure(param1:WindowEvent, param2:IWindowModel) : void
      {
         if(param1.type == "WME_CLICK")
         {
            if(_navigator.liftDataContainer.liftedRooms.length > UnknownVarFromLiftView_Int_1)
            {
               _navigator.goToRoom(_navigator.liftDataContainer.liftedRooms[UnknownVarFromLiftView_Int_1].flatId,"promotion");
            }
         }
      }
   }
}

