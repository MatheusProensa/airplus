package com.sulake.habbo.avatar.nft
{
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IItemGridWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.avatar.common.ICategoryBaseModel_2;
   import com.sulake.habbo.avatar.wardrobe.NftOutfit;
   
   public class NftAvatarsView implements ICategoryBaseModel_2
   {
      private var _window:IWindowController_1;
      
      private var UnknownVarFromNftAvatarsView_NftAvatarsModel_1:NftAvatarsModel;
      
      private var UnknownVarFromNftAvatarsView_IItemGridWindow_1:IItemGridWindow;
      
      public function NftAvatarsView(param1:NftAvatarsModel)
      {
         super();
         UnknownVarFromNftAvatarsView_NftAvatarsModel_1 = param1;
      }
      
      public function init() : void
      {
         if(UnknownVarFromNftAvatarsView_IItemGridWindow_1)
         {
            UnknownVarFromNftAvatarsView_IItemGridWindow_1.removeGridItems();
         }
         if(!_window)
         {
            _window = UnknownVarFromNftAvatarsView_NftAvatarsModel_1.controller.view.getCategoryContainer("nfts") as IWindowController_1;
            UnknownVarFromNftAvatarsView_IItemGridWindow_1 = _window.findChildByName("nfts") as IItemGridWindow;
            _window.visible = false;
         }
         update();
      }
      
      public function dispose() : void
      {
         UnknownVarFromNftAvatarsView_IItemGridWindow_1.removeGridItems();
         _window = null;
         UnknownVarFromNftAvatarsView_NftAvatarsModel_1 = null;
      }
      
      public function update() : void
      {
         var _loc2_:IWindowModel = null;
         UnknownVarFromNftAvatarsView_IItemGridWindow_1.removeGridItems();
         for each(var _loc1_ in UnknownVarFromNftAvatarsView_NftAvatarsModel_1.nftAvatars)
         {
            _loc2_ = _loc1_.view.window;
            UnknownVarFromNftAvatarsView_IItemGridWindow_1.addGridItem(_loc2_);
            _loc2_.procedure = nftAvatarsEventProc;
         }
      }
      
      public function getWindowContainer() : IWindowController_1
      {
         return _window;
      }
      
      private function nftAvatarsEventProc(param1:WindowEvent, param2:IWindowModel = null) : void
      {
         var _loc3_:int = 0;
         if(param2 == null)
         {
            param2 = param1.target as IWindowModel;
         }
         if(param1.type == "WME_CLICK")
         {
            _loc3_ = UnknownVarFromNftAvatarsView_IItemGridWindow_1.getGridItemIndex(param2.parent);
            UnknownVarFromNftAvatarsView_NftAvatarsModel_1.selectNftAvatar(_loc3_);
         }
      }
      
      public function switchCategory(param1:String) : void
      {
      }
      
      public function showPalettes(param1:String, param2:int) : void
      {
      }
      
      public function reset() : void
      {
      }
   }
}

