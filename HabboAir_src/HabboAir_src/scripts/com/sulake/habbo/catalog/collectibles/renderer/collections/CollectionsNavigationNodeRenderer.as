package com.sulake.habbo.catalog.collectibles.renderer.collections
{
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.UnknownICoreWindowComponents6;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.catalog.collectibles.tabs.CollectionsTab;
   import com.sulake.habbo.communication.messages.parser.collectibles.NftCollection;
   
   public class CollectionsNavigationNodeRenderer implements IComponentInterfaceQueue
   {
      private var UnknownVarFromCollectionsNavigationNodeRenderer_CollectionsTab_1:CollectionsTab;
      
      private var _nftCollection:NftCollection;
      
      private var _window:IWindowController_1;
      
      private var _active:Boolean;
      
      private var _itemNormalColor:uint;
      
      private var _itemSelectedEtchingColor:uint;
      
      private var UnknownVarFromCollectionsNavigationNodeRenderer_Boolean_1:Boolean = false;
      
      public function CollectionsNavigationNodeRenderer(param1:CollectionsTab, param2:NftCollection)
      {
         super();
         UnknownVarFromCollectionsNavigationNodeRenderer_CollectionsTab_1 = param1;
         _nftCollection = param2;
         createWindow();
      }
      
      private function createWindow() : void
      {
         _window = UnknownVarFromCollectionsNavigationNodeRenderer_CollectionsTab_1.navigationItemTemplate.clone() as IWindowController_1;
         var _loc1_:ITextWindow = _window.findChildByTag("ITEM_TITLE") as ITextWindow;
         if(_loc1_ != null)
         {
            _loc1_.caption = UnknownVarFromCollectionsNavigationNodeRenderer_CollectionsTab_1.controller.localizationManager.getLocalization("collectibles.set." + _nftCollection.collectionId,nftCollection.collectionName);
            _itemNormalColor = _loc1_.textColor;
            _itemSelectedEtchingColor = _loc1_.etchingColor;
         }
         var _loc2_:IWindowModel = _window.findChildByTag("SELECTION_HILIGHT");
         if(_loc2_)
         {
            _loc2_.visible = false;
         }
         setProgressLook(false);
         _window.addEventListener("WME_CLICK",onButtonClicked);
         _window.addEventListener("WME_OVER",onOver);
         _window.addEventListener("WME_OUT",onOut);
      }
      
      private function setProgressLook(param1:Boolean = false) : void
      {
         var _loc4_:* = 0;
         var _loc5_:int = 0;
         var _loc2_:int = _nftCollection.collectedItemCount;
         var _loc3_:int = _nftCollection.totalItemCount;
         progressContainer.visible = _loc2_ > 0 && param1;
         progressColorHint.visible = _loc2_ > 0;
         if(_loc2_ > 0)
         {
            _loc4_ = CollectionProgressColorUtil.getColor(_loc2_,_loc3_);
            progressColorHint.color = _loc4_ | 4278190080;
            if(param1)
            {
               _loc5_ = _nftCollection.collectedItemCount * 100 / _nftCollection.totalItemCount;
               progressColor.color = _loc4_;
               progressText.caption = _loc5_ + "%";
            }
         }
      }
      
      public function get nftCollection() : NftCollection
      {
         return _nftCollection;
      }
      
      public function get window() : IWindowController_1
      {
         return _window;
      }
      
      public function activate() : void
      {
         _active = true;
         updateLook();
      }
      
      public function deactivate() : void
      {
         _active = false;
         updateLook();
      }
      
      private function onOut(param1:WindowMouseEvent) : void
      {
         UnknownVarFromCollectionsNavigationNodeRenderer_Boolean_1 = false;
         updateLook();
      }
      
      private function onOver(param1:WindowMouseEvent) : void
      {
         UnknownVarFromCollectionsNavigationNodeRenderer_Boolean_1 = true;
         updateLook();
      }
      
      private function updateLook() : void
      {
         if(_active || UnknownVarFromCollectionsNavigationNodeRenderer_Boolean_1)
         {
            setActiveLook();
         }
         else
         {
            setInactiveLook();
         }
         setProgressLook(UnknownVarFromCollectionsNavigationNodeRenderer_Boolean_1);
      }
      
      private function setInactiveLook() : void
      {
         var _loc1_:ITextWindow = null;
         var _loc2_:IWindowModel = null;
         if(_window != null)
         {
            _loc1_ = _window.findChildByTag("SELECTION_COLOR") as ITextWindow;
            if(_loc1_ != null)
            {
               _loc1_.textColor = _itemNormalColor;
               _loc1_.etchingColor = 0;
            }
            _loc2_ = _window.findChildByTag("SELECTION_HILIGHT");
            if(_loc2_ != null)
            {
               _loc2_.visible = false;
            }
         }
      }
      
      private function setActiveLook() : void
      {
         var _loc1_:ITextWindow = null;
         var _loc2_:IWindowController_1 = null;
         if(_window != null)
         {
            _loc1_ = _window.findChildByTag("SELECTION_COLOR") as ITextWindow;
            if(_loc1_ != null)
            {
               _loc1_.textColor = 4294967295;
               _loc1_.etchingColor = _itemSelectedEtchingColor;
            }
            _loc2_ = _window.findChildByTag("SELECTION_HILIGHT") as IWindowController_1;
            if(_loc2_ != null)
            {
               _loc2_.visible = true;
            }
         }
      }
      
      private function get progressContainer() : IWindowController_1
      {
         return IWindowController_1(_window.findChildByName("progress_container"));
      }
      
      private function get progressColor() : UnknownICoreWindowComponents6
      {
         return UnknownICoreWindowComponents6(progressContainer.getChildByName("progress_color"));
      }
      
      private function get progressText() : ITextWindow
      {
         return ITextWindow(progressContainer.getChildByName("progress_text"));
      }
      
      private function get progressColorHint() : IWindowController_1
      {
         return IWindowController_1(_window.findChildByName("progress_color_hint"));
      }
      
      private function onButtonClicked(param1:WindowMouseEvent) : void
      {
         UnknownVarFromCollectionsNavigationNodeRenderer_CollectionsTab_1.activateCollection(this);
      }
      
      public function dispose() : void
      {
         if(_window == null)
         {
            return;
         }
         _window.dispose();
         _window = null;
      }
      
      public function get disposed() : Boolean
      {
         return _window == null;
      }
   }
}

