package com.sulake.habbo.avatar
{
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IFrameController;
   import com.sulake.core.window.components.ITabButtonWindow;
   import com.sulake.core.window.components.ITabContextWindow;
   import com.sulake.core.window.components.IWidgetWindowController;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.avatar.common.AvatarEditorGridView;
   import com.sulake.habbo.avatar.common.IAvatarEditorGridView;
   import com.sulake.habbo.avatar.effects.AvatarEditorGridViewEffects;
   import com.sulake.habbo.avatar.view.AvatarEditorNameChangeView;
   import flash.events.Event;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.Dictionary;
   import flash.utils.Timer;
   
   public class AvatarEditorView
   {
      public static var THUMB_WINDOW:IWindowController_1;
      
      public static var COLOUR_WINDOW:IWindowController_1;
      
      public static var TAB_BACKGROUND_COLOUR:int = 6710886;
      
      private static const SAVE_TIMEOUT_MS:int = 1500;
      
      private static const DEFAULT_LOCATION:Point = new Point(100,30);
      
      private var _editor:HabboAvatarEditor;
      
      private var UnknownVarFromAvatarEditorView_IWindowController_1_1:IWindowController_1;
      
      private var _currentViewId:String;
      
      private var UnknownVarFromAvatarEditorView_ITabContextWindow_1:ITabContextWindow;
      
      private var UnknownVarFromAvatarEditorView_IFrameController_1:IFrameController;
      
      private var UnknownVarFromAvatarEditorView_IWindowController_1_2:IWindowController_1;
      
      private var UnknownVarFromAvatarEditorView_Timer_1:Timer;
      
      private var UnknownVarFromAvatarEditorView_Int_1:int = 4;
      
      private var UnknownVarFromAvatarEditorView_String_1:String;
      
      private var _showWardrobeOnUpdate:Boolean = true;
      
      private var _availableCategories:Array = [];
      
      private var _allCategories:Array = ["generic","head","torso","legs","hotlooks","wardrobe","nfts"];
      
      private var _categoryContainers:Dictionary;
      
      private var _gridView:IAvatarEditorGridView;
      
      private var _effectsGridView:IAvatarEditorGridView;
      
      private var _avatarEditorNameChangeView:AvatarEditorNameChangeView;
      
      public function AvatarEditorView(param1:HabboAvatarEditor, param2:Array)
      {
         super();
         _editor = param1;
         UnknownVarFromAvatarEditorView_Timer_1 = new Timer(1500,1);
         UnknownVarFromAvatarEditorView_Timer_1.addEventListener("timer",onUpdate);
         if(param1.manager.getBoolean("effects.in.avatar.editor"))
         {
            _allCategories.push("effects");
         }
         if(this.editor.isDevelopmentEditor() == true)
         {
            _allCategories = ["generic","head","torso","legs"];
         }
         if(param1.manager.getBoolean("clothing.misc.tab.enabled"))
         {
            _allCategories.push("misc");
         }
         if(param2 == null)
         {
            param2 = _allCategories;
         }
         for each(var _loc3_ in param2)
         {
            _availableCategories.push(_loc3_);
         }
         createWindow();
      }
      
      public function dispose() : void
      {
         var _loc3_:IWindowController_1 = null;
         var _loc2_:IWindowController_1 = null;
         var _loc1_:IWindowController_1 = null;
         if(UnknownVarFromAvatarEditorView_Timer_1 != null)
         {
            UnknownVarFromAvatarEditorView_Timer_1.stop();
            UnknownVarFromAvatarEditorView_Timer_1.removeEventListener("timer",onUpdate);
            UnknownVarFromAvatarEditorView_Timer_1 = null;
         }
         if(UnknownVarFromAvatarEditorView_ITabContextWindow_1)
         {
            UnknownVarFromAvatarEditorView_ITabContextWindow_1.dispose();
            UnknownVarFromAvatarEditorView_ITabContextWindow_1 = null;
         }
         if(UnknownVarFromAvatarEditorView_IWindowController_1_1)
         {
            UnknownVarFromAvatarEditorView_IWindowController_1_1.dispose();
            UnknownVarFromAvatarEditorView_IWindowController_1_1 = null;
         }
         if(UnknownVarFromAvatarEditorView_IWindowController_1_2 != null)
         {
            UnknownVarFromAvatarEditorView_IWindowController_1_2.dispose();
            UnknownVarFromAvatarEditorView_IWindowController_1_2 = null;
         }
         if(UnknownVarFromAvatarEditorView_IFrameController_1)
         {
            UnknownVarFromAvatarEditorView_IFrameController_1.dispose();
            UnknownVarFromAvatarEditorView_IFrameController_1 = null;
         }
         if(UnknownVarFromAvatarEditorView_IWindowController_1_1 != null)
         {
            _loc3_ = UnknownVarFromAvatarEditorView_IWindowController_1_1.findChildByName("figureContainer") as IWindowController_1;
            if(_loc3_ != null)
            {
               while(_loc3_.numChildren > 0)
               {
                  _loc3_.removeChildAt(0);
               }
            }
            _loc2_ = UnknownVarFromAvatarEditorView_IWindowController_1_1.findChildByName("contentArea") as IWindowController_1;
            if(_loc2_ != null)
            {
               while(_loc2_.numChildren > 0)
               {
                  _loc2_.removeChildAt(0);
               }
            }
            _loc1_ = UnknownVarFromAvatarEditorView_IWindowController_1_1.findChildByName("sideContainer") as IWindowController_1;
            if(_loc1_ != null)
            {
               while(_loc1_.numChildren > 0)
               {
                  _loc1_.removeChildAt(0);
               }
            }
            _editor = null;
         }
      }
      
      public function getFrame(param1:Array, param2:String = null) : IFrameController
      {
         if(UnknownVarFromAvatarEditorView_IFrameController_1)
         {
            UnknownVarFromAvatarEditorView_IFrameController_1.visible = true;
            UnknownVarFromAvatarEditorView_IFrameController_1.activate();
            return UnknownVarFromAvatarEditorView_IFrameController_1;
         }
         if(UnknownVarFromAvatarEditorView_IFrameController_1)
         {
            UnknownVarFromAvatarEditorView_IFrameController_1.dispose();
            UnknownVarFromAvatarEditorView_IFrameController_1 = null;
         }
         var _loc3_:XmlAsset = _editor.manager.assets.getAssetByName("AvatarEditorFrame") as XmlAsset;
         if(_loc3_)
         {
            UnknownVarFromAvatarEditorView_IFrameController_1 = _editor.manager.windowManager.buildFromXML(_loc3_.content as XML) as IFrameController;
         }
         if(UnknownVarFromAvatarEditorView_IFrameController_1 == null)
         {
            return null;
         }
         var _loc4_:IWindowController_1 = UnknownVarFromAvatarEditorView_IFrameController_1.findChildByName("maincontent") as IWindowController_1;
         if(!embedToContext(_loc4_,param1))
         {
            UnknownVarFromAvatarEditorView_IFrameController_1.dispose();
            UnknownVarFromAvatarEditorView_IFrameController_1 = null;
            return null;
         }
         if(param2 && UnknownVarFromAvatarEditorView_IFrameController_1.header != null)
         {
            UnknownVarFromAvatarEditorView_IFrameController_1.header.title.text = param2;
         }
         UnknownVarFromAvatarEditorView_IFrameController_1.position = DEFAULT_LOCATION;
         UnknownVarFromAvatarEditorView_IFrameController_1.findChildByName("header_button_close").procedure = windowEventProc;
         if(this.editor.isDevelopmentEditor() == true)
         {
            UnknownVarFromAvatarEditorView_IFrameController_1.caption = "Developer Wardrobe";
         }
         return UnknownVarFromAvatarEditorView_IFrameController_1;
      }
      
      public function embedToContext(param1:IWindowController_1, param2:Array) : Boolean
      {
         var _loc3_:int = 0;
         if(!validateAvailableCategories(param2))
         {
            return false;
         }
         if(param1)
         {
            _loc3_ = int(param1.getChildIndex(UnknownVarFromAvatarEditorView_IWindowController_1_1));
            if(_loc3_)
            {
               param1.removeChildAt(_loc3_);
            }
            param1.addChild(UnknownVarFromAvatarEditorView_IWindowController_1_1);
         }
         else
         {
            if(UnknownVarFromAvatarEditorView_IWindowController_1_2 == null)
            {
               UnknownVarFromAvatarEditorView_IWindowController_1_2 = _editor.manager.windowManager.createWindow("avatarEditorContainer","",4,3,131072 | 1,new Rectangle(0,0,2,2),null,0) as IWindowController_1;
               UnknownVarFromAvatarEditorView_IWindowController_1_2.addChild(UnknownVarFromAvatarEditorView_IWindowController_1_1);
            }
            _loc3_ = int(UnknownVarFromAvatarEditorView_IWindowController_1_2.getChildIndex(UnknownVarFromAvatarEditorView_IWindowController_1_1));
            if(_loc3_)
            {
               param1.removeChildAt(_loc3_);
            }
            UnknownVarFromAvatarEditorView_IWindowController_1_2.visible = true;
         }
         return true;
      }
      
      public function validateAvailableCategories(param1:Array) : Boolean
      {
         if(param1 == null)
         {
            return validateAvailableCategories(_allCategories);
         }
         if(param1.length != _availableCategories.length)
         {
            return false;
         }
         for each(var _loc2_ in param1)
         {
            if(_availableCategories.indexOf(_loc2_) < 0)
            {
               return false;
            }
         }
         return true;
      }
      
      private function onUpdate(param1:Event = null) : void
      {
         UnknownVarFromAvatarEditorView_Timer_1.stop();
         if(UnknownVarFromAvatarEditorView_IWindowController_1_1)
         {
            UnknownVarFromAvatarEditorView_IWindowController_1_1.findChildByName("save").enable();
         }
      }
      
      public function show() : void
      {
         if(UnknownVarFromAvatarEditorView_IFrameController_1)
         {
            UnknownVarFromAvatarEditorView_IFrameController_1.visible = true;
         }
         else if(UnknownVarFromAvatarEditorView_IWindowController_1_1)
         {
            UnknownVarFromAvatarEditorView_IWindowController_1_1.visible = true;
         }
      }
      
      public function hide() : void
      {
         if(UnknownVarFromAvatarEditorView_IFrameController_1)
         {
            UnknownVarFromAvatarEditorView_IFrameController_1.visible = false;
         }
         else if(UnknownVarFromAvatarEditorView_IWindowController_1_1)
         {
            UnknownVarFromAvatarEditorView_IWindowController_1_1.visible = false;
         }
      }
      
      private function createWindow() : void
      {
         var _loc4_:int = 0;
         var _loc3_:ITabButtonWindow = null;
         var _loc5_:int = 0;
         var _loc7_:IWindowModel = null;
         if(UnknownVarFromAvatarEditorView_IWindowController_1_1 == null)
         {
            UnknownVarFromAvatarEditorView_IWindowController_1_1 = _editor.manager.windowManager.buildFromXML((_editor.manager.assets.getAssetByName("AvatarEditorContent") as XmlAsset).content as XML) as IWindowController_1;
         }
         if(THUMB_WINDOW == null)
         {
            THUMB_WINDOW = UnknownVarFromAvatarEditorView_IWindowController_1_1.findChildByName("thumb_template") as IWindowController_1;
            if(THUMB_WINDOW)
            {
               UnknownVarFromAvatarEditorView_IWindowController_1_1.removeChild(THUMB_WINDOW);
            }
         }
         if(COLOUR_WINDOW == null)
         {
            COLOUR_WINDOW = UnknownVarFromAvatarEditorView_IWindowController_1_1.findChildByName("palette_template") as IWindowController_1;
            if(COLOUR_WINDOW)
            {
               UnknownVarFromAvatarEditorView_IWindowController_1_1.removeChild(COLOUR_WINDOW);
            }
         }
         if(_editor.manager != null && _editor.manager.sessionData != null)
         {
            UnknownVarFromAvatarEditorView_IWindowController_1_1.findChildByName("avatar_name").caption = _editor.manager.sessionData.userName;
            if(_editor.manager.getBoolean("premium.name.change.enabled"))
            {
               UnknownVarFromAvatarEditorView_IWindowController_1_1.findChildByName("avatar_name_change").visible = true;
            }
         }
         UnknownVarFromAvatarEditorView_IWindowController_1_1.procedure = windowEventProc;
         UnknownVarFromAvatarEditorView_ITabContextWindow_1 = UnknownVarFromAvatarEditorView_IWindowController_1_1.findChildByName("mainTabs") as ITabContextWindow;
         var _loc1_:Vector.<String> = new Vector.<String>(0);
         _loc4_ = UnknownVarFromAvatarEditorView_ITabContextWindow_1.numTabItems - 1;
         while(_loc4_ >= 0)
         {
            _loc3_ = UnknownVarFromAvatarEditorView_ITabContextWindow_1.getTabItemAt(_loc4_);
            _loc1_.push(_loc3_.name);
            if(_loc3_ != null && _availableCategories.indexOf(_loc3_.name) < 0)
            {
               UnknownVarFromAvatarEditorView_ITabContextWindow_1.removeTabItem(_loc3_);
               _loc5_ = _loc4_ + 1;
               while(_loc5_ < UnknownVarFromAvatarEditorView_ITabContextWindow_1.numTabItems)
               {
                  UnknownVarFromAvatarEditorView_ITabContextWindow_1.getTabItemAt(_loc5_).x = UnknownVarFromAvatarEditorView_ITabContextWindow_1.getTabItemAt(_loc5_).x - _loc3_.width;
                  _loc5_++;
               }
            }
            _loc4_--;
         }
         _categoryContainers = new Dictionary();
         var _loc2_:IWindowController_1 = UnknownVarFromAvatarEditorView_IWindowController_1_1.findChildByName("contentArea") as IWindowController_1;
         for each(var _loc6_ in _loc1_)
         {
            _loc7_ = _loc2_.findChildByName(_loc6_ + "_content");
            if(_loc7_)
            {
               _categoryContainers[_loc6_] = _loc2_.removeChild(_loc7_);
            }
         }
         _gridView = new AvatarEditorGridView(UnknownVarFromAvatarEditorView_IWindowController_1_1.findChildByName("grid_container") as IWindowController_1);
         _effectsGridView = new AvatarEditorGridViewEffects(UnknownVarFromAvatarEditorView_IWindowController_1_1.findChildByName("grid_container") as IWindowController_1);
         UnknownVarFromAvatarEditorView_ITabContextWindow_1.selector.setSelected(UnknownVarFromAvatarEditorView_ITabContextWindow_1.getTabItemAt(0));
         update();
      }
      
      public function update() : void
      {
         var _loc1_:IWindowModel = UnknownVarFromAvatarEditorView_IWindowController_1_1.findChildByName("wardrobeButtonContainer") as IWindowModel;
         if(_loc1_ && _editor.manager.sessionData)
         {
            _loc1_.visible = _editor.manager.sessionData.hasClub && _editor.isSideContentEnabled();
            _loc1_.visible = _editor.isSideContentEnabled();
         }
         var _loc2_:String = "nothing";
         if(UnknownVarFromAvatarEditorView_String_1 == "wardrobe" || _showWardrobeOnUpdate)
         {
            _loc2_ = "wardrobe";
         }
         if(!_editor.isSideContentEnabled())
         {
            _loc2_ = "nothing";
         }
         if(_editor.hasInvalidClubItems())
         {
            _editor.stripClubItems();
            _editor.disableClubClothing();
         }
         if(_editor.hasInvalidSellableItems())
         {
            _editor.stripInvalidSellableItems();
         }
         setSideContent(_loc2_);
         setViewToCategory(_currentViewId);
      }
      
      public function toggleCategoryView(param1:String, param2:Boolean = false) : void
      {
         if(param2)
         {
         }
         setViewToCategory(param1);
      }
      
      private function toggleWardrobe() : void
      {
         if(UnknownVarFromAvatarEditorView_String_1 == "wardrobe")
         {
            _showWardrobeOnUpdate = false;
            setSideContent("nothing");
         }
         else
         {
            setSideContent("wardrobe");
         }
      }
      
      private function setSideContent(param1:String) : void
      {
         if(UnknownVarFromAvatarEditorView_String_1 == param1)
         {
            return;
         }
         var _loc2_:IWindowController_1 = UnknownVarFromAvatarEditorView_IWindowController_1_1.findChildByName("sideContainer") as IWindowController_1;
         if(!_loc2_)
         {
            return;
         }
         var _loc4_:IWindowModel = null;
         switch(param1)
         {
            case "nothing":
               break;
            case "wardrobe":
               _loc4_ = _editor.getSideContentWindowContainer("wardrobe");
         }
         var _loc3_:IWindowModel = _loc2_.removeChildAt(0);
         if(_loc3_)
         {
            UnknownVarFromAvatarEditorView_IWindowController_1_1.width -= _loc3_.width;
         }
         if(_loc4_)
         {
            _loc2_.addChild(_loc4_);
            _loc4_.visible = true;
            _loc2_.width = _loc4_.width;
         }
         else
         {
            _loc2_.width = 1;
         }
         UnknownVarFromAvatarEditorView_String_1 = param1;
         if(UnknownVarFromAvatarEditorView_IFrameController_1)
         {
            UnknownVarFromAvatarEditorView_IFrameController_1.content.width = UnknownVarFromAvatarEditorView_IWindowController_1_1.width;
         }
      }
      
      private function setViewToCategory(param1:String) : void
      {
         if(param1 == null || param1 == "")
         {
            return;
         }
         var _loc2_:IWindowController_1 = UnknownVarFromAvatarEditorView_IWindowController_1_1.findChildByName("contentArea") as IWindowController_1;
         if(_loc2_ == null)
         {
            return;
         }
         effectsParamViewContainer.visible = param1 == "effects";
         collectiblesAvatarInfoContainer.visible = false;
         if("nfts" == param1)
         {
            _showWardrobeOnUpdate = false;
            UnknownVarFromAvatarEditorView_IWindowController_1_1.findChildByName("wardrobe").disable();
            setSideContent("nothing");
         }
         else
         {
            UnknownVarFromAvatarEditorView_IWindowController_1_1.findChildByName("wardrobe").enable();
         }
         var _loc4_:IWindowModel = _loc2_.getChildAt(0);
         _loc2_.removeChild(_loc4_);
         _loc2_.invalidate();
         var _loc3_:IWindowModel = _editor.getCategoryWindowContainer(param1);
         if(_loc3_ == null)
         {
            return;
         }
         _gridView.window.visible = false;
         _loc3_.visible = true;
         _loc2_.addChild(_loc3_);
         _editor.activateCategory(param1);
         _currentViewId = param1;
         UnknownVarFromAvatarEditorView_ITabContextWindow_1.selector.setSelected(UnknownVarFromAvatarEditorView_ITabContextWindow_1.getTabItemByName(param1));
      }
      
      public function windowEventProc(param1:WindowEvent, param2:IWindowModel) : void
      {
         var _loc3_:String = null;
         var _loc6_:Boolean = false;
         var _loc4_:Boolean = false;
         var _loc5_:Boolean = false;
         if(param1.type == "WE_SELECTED")
         {
            _loc3_ = (param2 as ITabContextWindow).selector.getSelected().name;
            if(_loc3_ != _currentViewId)
            {
               _loc6_ = false;
               _loc4_ = false;
               _loc5_ = false;
               if(_loc3_ != "effects" && _loc3_ != "hotlooks")
               {
                  if(_editor.hasNftOutfit() && "nfts" == _loc3_)
                  {
                     _loc5_ = true;
                  }
                  else if(_editor.hasNftOutfit() && _loc3_ != "nfts")
                  {
                     _loc6_ = true;
                  }
                  else if(editor.hasSetNftOutfitInViewer() && _loc3_ != "nfts")
                  {
                     _loc4_ = true;
                  }
               }
               if(_editor.hasNftOutfit() && _loc3_ == "effects")
               {
                  _loc5_ = true;
               }
               _editor.toggleAvatarEditorPage(_loc3_);
               if(_loc6_)
               {
                  _editor.loadFallbackFigure();
               }
               else if(_loc4_)
               {
                  _editor.loadRollbackFigure();
               }
               else if(_loc5_)
               {
                  _editor.loadNftFigure();
               }
            }
         }
         else if(param1.type == "WME_CLICK")
         {
            switch(param2.name)
            {
               case "save":
                  if(!_editor.isDevelopmentEditor() && _editor.hasInvalidSellableItems())
                  {
                     startSellablePurchase();
                     UnknownVarFromAvatarEditorView_Timer_1.start();
                     UnknownVarFromAvatarEditorView_IWindowController_1_1.findChildByName("save").disable();
                     return;
                  }
                  if(!_editor.isDevelopmentEditor() && _editor.hasInvalidClubItems())
                  {
                     _editor.openHabboClubAdWindow();
                     UnknownVarFromAvatarEditorView_Timer_1.start();
                     UnknownVarFromAvatarEditorView_IWindowController_1_1.findChildByName("save").disable();
                     return;
                  }
                  UnknownVarFromAvatarEditorView_Timer_1.start();
                  UnknownVarFromAvatarEditorView_IWindowController_1_1.findChildByName("save").disable();
                  _editor.saveCurrentSelection();
                  _editor.manager.close(_editor.instanceId);
                  break;
               case "cancel":
               case "header_button_close":
                  if(_editor.hasInvalidClubItems())
                  {
                     _editor.stripClubItems();
                     _editor.disableClubClothing();
                  }
                  _editor.manager.close(_editor.instanceId);
                  break;
               case "rotate_avatar":
                  UnknownVarFromAvatarEditorView_Int_1++;
                  if(UnknownVarFromAvatarEditorView_Int_1 > 7)
                  {
                     UnknownVarFromAvatarEditorView_Int_1 = 0;
                  }
                  _editor.figureData.direction = UnknownVarFromAvatarEditorView_Int_1;
                  break;
               case "wardrobe":
                  toggleWardrobe();
                  break;
               case "avatar_name_change":
                  if(_avatarEditorNameChangeView != null)
                  {
                     _avatarEditorNameChangeView.focus();
                  }
                  else
                  {
                     _avatarEditorNameChangeView = new AvatarEditorNameChangeView(this,UnknownVarFromAvatarEditorView_IWindowController_1_1.x + UnknownVarFromAvatarEditorView_IWindowController_1_1.width,UnknownVarFromAvatarEditorView_IWindowController_1_1.y);
                  }
            }
         }
      }
      
      private function startSellablePurchase() : void
      {
         if(_editor.manager.catalog)
         {
            _editor.manager.catalog.openCatalogPage(_editor.manager.getProperty("catalog.clothes.page"));
         }
      }
      
      public function get effectsParamViewContainer() : IWindowController_1
      {
         return IWindowController_1(UnknownVarFromAvatarEditorView_IWindowController_1_1.findChildByName("effectParamsContainer"));
      }
      
      public function get collectiblesAvatarInfoContainer() : IWindowController_1
      {
         return IWindowController_1(UnknownVarFromAvatarEditorView_IWindowController_1_1.findChildByName("collectible_avatar_info"));
      }
      
      public function getCategoryContainer(param1:String) : IWindowModel
      {
         return _categoryContainers[param1];
      }
      
      public function get gridView() : IAvatarEditorGridView
      {
         return _gridView;
      }
      
      public function getFigureContainer() : IWidgetWindowController
      {
         return UnknownVarFromAvatarEditorView_IWindowController_1_1.findChildByName("avatarWidget") as IWidgetWindowController;
      }
      
      public function get effectsGridView() : IAvatarEditorGridView
      {
         return _effectsGridView;
      }
      
      public function get editor() : HabboAvatarEditor
      {
         return _editor;
      }
      
      public function get avatarEditorNameChangeView() : AvatarEditorNameChangeView
      {
         return _avatarEditorNameChangeView;
      }
      
      public function get currentViewId() : String
      {
         return _currentViewId;
      }
   }
}

