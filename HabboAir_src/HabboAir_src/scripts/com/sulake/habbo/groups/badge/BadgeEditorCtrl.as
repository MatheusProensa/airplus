package com.sulake.habbo.groups.badge
{
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.components.IBitmapWrapperController;
   import com.sulake.core.window.components.IItemGridWindow;
   import com.sulake.habbo.communication.messages.incoming.users.GuildBadgeSettings;
   import com.sulake.habbo.groups.*;
   import com.sulake.habbo.groups.events.HabboGroupsEditorData;
   import flash.display.BitmapData;
   import flash.geom.Point;
   
   public class BadgeEditorCtrl implements IComponentInterfaceQueue
   {
      private var UnknownVarFromBadgeEditorCtrl_HabboGroupsManager_1:HabboGroupsManager;
      
      private var _window:IWindowController_1;
      
      private var UnknownVarFromBadgeEditorCtrl_IWindowController_1_1:IWindowController_1;
      
      private var UnknownVarFromBadgeEditorCtrl_Array_1:Array;
      
      private var _badgeSelectPartCtrl:BadgeSelectPartCtrl;
      
      private var _disposed:Boolean = false;
      
      private var _layers:Vector.<BadgeLayerCtrl>;
      
      private var _currentLayerOptions:BadgeLayerOptions;
      
      private var _partSelectContainer:IWindowController_1;
      
      private var _partSelectGrid:IItemGridWindow;
      
      private var _partEditContainer:IWindowController_1;
      
      private var _badgePreviewImages:Vector.<IBitmapWrapperController>;
      
      public function BadgeEditorCtrl(param1:HabboGroupsManager)
      {
         super();
         UnknownVarFromBadgeEditorCtrl_HabboGroupsManager_1 = param1;
         UnknownVarFromBadgeEditorCtrl_HabboGroupsManager_1.events.addEventListener("HGE_EDIT_INFO",onHabboGroupsEditorData);
         _badgeSelectPartCtrl = new BadgeSelectPartCtrl(UnknownVarFromBadgeEditorCtrl_HabboGroupsManager_1,this);
         _layers = new Vector.<BadgeLayerCtrl>();
         _layers.push(new BadgeLayerCtrl(UnknownVarFromBadgeEditorCtrl_HabboGroupsManager_1,this,0));
         _layers.push(new BadgeLayerCtrl(UnknownVarFromBadgeEditorCtrl_HabboGroupsManager_1,this,1));
         _layers.push(new BadgeLayerCtrl(UnknownVarFromBadgeEditorCtrl_HabboGroupsManager_1,this,2));
         _layers.push(new BadgeLayerCtrl(UnknownVarFromBadgeEditorCtrl_HabboGroupsManager_1,this,3));
         _layers.push(new BadgeLayerCtrl(UnknownVarFromBadgeEditorCtrl_HabboGroupsManager_1,this,4));
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function get partEditContainer() : IWindowController_1
      {
         return _partEditContainer;
      }
      
      public function get partSelectContainer() : IWindowController_1
      {
         return _partSelectContainer;
      }
      
      public function get partSelectGrid() : IItemGridWindow
      {
         return _partSelectGrid;
      }
      
      public function get currentLayerOptions() : BadgeLayerOptions
      {
         return _currentLayerOptions;
      }
      
      public function get badgeSelectPartCtrl() : BadgeSelectPartCtrl
      {
         return _badgeSelectPartCtrl;
      }
      
      public function get isIntialized() : Boolean
      {
         return _window != null && UnknownVarFromBadgeEditorCtrl_Array_1 != null;
      }
      
      public function dispose() : void
      {
         if(!_disposed)
         {
            if(_layers)
            {
               for each(var _loc1_ in _layers)
               {
                  _loc1_.dispose();
               }
               _layers = null;
            }
            if(_badgeSelectPartCtrl)
            {
               _badgeSelectPartCtrl.dispose();
               _badgeSelectPartCtrl = null;
            }
            if(_partSelectContainer)
            {
               _partSelectContainer.dispose();
               _partSelectContainer = null;
            }
            if(_partSelectGrid)
            {
               _partSelectGrid.dispose();
               _partSelectGrid = null;
            }
            if(_partEditContainer)
            {
               _partEditContainer.dispose();
               _partEditContainer = null;
            }
            if(_badgePreviewImages)
            {
               for each(var _loc2_ in _badgePreviewImages)
               {
                  _loc2_.dispose();
               }
               _badgePreviewImages = null;
            }
            if(_window)
            {
               _window.dispose();
               _window = null;
            }
            UnknownVarFromBadgeEditorCtrl_Array_1 = null;
            _currentLayerOptions = null;
            _window = null;
            UnknownVarFromBadgeEditorCtrl_HabboGroupsManager_1 = null;
            _disposed = true;
         }
      }
      
      public function onHabboGroupsEditorData(param1:HabboGroupsEditorData) : void
      {
         _badgeSelectPartCtrl.loadData();
         createWindow(null,null);
      }
      
      public function createWindow(param1:IWindowController_1, param2:Array) : void
      {
         var _loc3_:int = 0;
         if(_window != null || _disposed)
         {
            return;
         }
         if(param1 != null)
         {
            UnknownVarFromBadgeEditorCtrl_IWindowController_1_1 = param1;
         }
         if(param2 != null)
         {
            UnknownVarFromBadgeEditorCtrl_Array_1 = param2;
         }
         if(UnknownVarFromBadgeEditorCtrl_IWindowController_1_1 == null || UnknownVarFromBadgeEditorCtrl_Array_1 == null || UnknownVarFromBadgeEditorCtrl_HabboGroupsManager_1 == null || UnknownVarFromBadgeEditorCtrl_HabboGroupsManager_1.guildEditorData == null)
         {
            return;
         }
         _window = UnknownVarFromBadgeEditorCtrl_HabboGroupsManager_1.getXmlWindow("badge_editor") as IWindowController_1;
         var _loc4_:IWindowController_1 = _window.findChildByName("guild_badge") as IWindowController_1;
         _badgePreviewImages = new Vector.<IBitmapWrapperController>();
         _badgePreviewImages.push(_loc4_.findChildByName("layer_0") as IBitmapWrapperController);
         _badgePreviewImages.push(_loc4_.findChildByName("layer_1") as IBitmapWrapperController);
         _badgePreviewImages.push(_loc4_.findChildByName("layer_2") as IBitmapWrapperController);
         _badgePreviewImages.push(_loc4_.findChildByName("layer_3") as IBitmapWrapperController);
         _badgePreviewImages.push(_loc4_.findChildByName("layer_4") as IBitmapWrapperController);
         _partEditContainer = _window.findChildByName("part_edit") as IWindowController_1;
         _partSelectContainer = _window.findChildByName("part_select") as IWindowController_1;
         _partSelectContainer.visible = false;
         _partSelectGrid = _partSelectContainer.findChildByName("part_select_grid") as IItemGridWindow;
         _loc3_ = 0;
         while(_loc3_ < _layers.length)
         {
            _layers[_loc3_].createWindow();
            _loc3_++;
         }
         resetLayerOptions(UnknownVarFromBadgeEditorCtrl_Array_1);
         UnknownVarFromBadgeEditorCtrl_IWindowController_1_1.addChild(_window);
      }
      
      public function resetLayerOptions(param1:Array) : void
      {
         var _loc2_:int = 0;
         if(!this.isIntialized)
         {
            return;
         }
         if(_partSelectContainer.visible)
         {
            _partSelectContainer.visible = false;
            _partEditContainer.visible = true;
         }
         UnknownVarFromBadgeEditorCtrl_Array_1 = param1;
         _currentLayerOptions = null;
         _partEditContainer.visible = true;
         _partSelectContainer.visible = false;
         _badgeSelectPartCtrl.loadData();
         _loc2_ = 0;
         while(_loc2_ < _layers.length)
         {
            _layers[_loc2_].setLayerOptions(createLayerOption(_loc2_));
            _layers[_loc2_].updateSelectedPart();
            _loc2_++;
         }
      }
      
      private function createLayerOption(param1:int) : BadgeLayerOptions
      {
         var _loc3_:int = 0;
         var _loc2_:GuildBadgeSettings = UnknownVarFromBadgeEditorCtrl_Array_1[param1] as GuildBadgeSettings;
         var _loc4_:BadgeLayerOptions = new BadgeLayerOptions();
         _loc4_.layerIndex = param1;
         _loc4_.colorIndex = 0;
         _loc4_.setGrid(_loc2_.position);
         _loc3_ = 0;
         while(_loc3_ < UnknownVarFromBadgeEditorCtrl_HabboGroupsManager_1.guildEditorData.badgeColors.length)
         {
            if(UnknownVarFromBadgeEditorCtrl_HabboGroupsManager_1.guildEditorData.badgeColors[_loc3_].id == _loc2_.colorId)
            {
               _loc4_.colorIndex = _loc3_;
               break;
            }
            _loc3_++;
         }
         if(param1 == BadgeLayerCtrl.BASE_LAYER_INDEX)
         {
            _loc3_ = 0;
            while(_loc3_ < UnknownVarFromBadgeEditorCtrl_HabboGroupsManager_1.guildEditorData.baseParts.length)
            {
               if(UnknownVarFromBadgeEditorCtrl_HabboGroupsManager_1.guildEditorData.baseParts[_loc3_].id == _loc2_.partId)
               {
                  _loc4_.partIndex = _loc3_;
                  break;
               }
               _loc3_++;
            }
         }
         else
         {
            _loc3_ = 0;
            while(_loc3_ < UnknownVarFromBadgeEditorCtrl_HabboGroupsManager_1.guildEditorData.layerParts.length)
            {
               if(UnknownVarFromBadgeEditorCtrl_HabboGroupsManager_1.guildEditorData.layerParts[_loc3_].id == _loc2_.partId)
               {
                  _loc4_.partIndex = _loc3_;
                  break;
               }
               _loc3_++;
            }
         }
         return _loc4_;
      }
      
      public function onPartSelected(param1:BadgeSelectPartCtrl) : void
      {
         _currentLayerOptions.partIndex = param1.getSelectedPartIndex();
         _layers[_currentLayerOptions.layerIndex].setLayerOptions(currentLayerOptions);
         _partEditContainer.visible = true;
         _partSelectContainer.visible = false;
      }
      
      public function onPartHover(param1:BadgeSelectPartCtrl) : void
      {
         updatePreviewImage(param1.layerOptions);
      }
      
      public function onPartChanged(param1:BadgeLayerCtrl) : void
      {
         updatePreviewImage(param1.layerOptions);
      }
      
      public function updatePreviewImage(param1:BadgeLayerOptions) : void
      {
         var _loc2_:BitmapData = _badgeSelectPartCtrl.getPartItemImage(param1);
         if(_loc2_ != null)
         {
            _badgePreviewImages[param1.layerIndex].bitmap = _loc2_.clone();
            _badgePreviewImages[param1.layerIndex].visible = true;
         }
         else
         {
            _badgePreviewImages[param1.layerIndex].visible = false;
         }
      }
      
      public function onShowSelectPart(param1:BadgeLayerCtrl) : void
      {
         var _loc2_:BadgeLayerOptions = _currentLayerOptions;
         _currentLayerOptions = param1.layerOptions.clone();
         if(!param1.layerOptions.equalVisuals(_loc2_))
         {
            _badgeSelectPartCtrl.updateGrid();
         }
         else
         {
            _badgeSelectPartCtrl.layerOptions = _currentLayerOptions.clone();
         }
         _partEditContainer.visible = false;
         _partSelectContainer.visible = true;
      }
      
      public function onViewChange() : void
      {
         if(isIntialized && Boolean(_partSelectContainer.visible))
         {
            updatePreviewImage(_currentLayerOptions);
            _partEditContainer.visible = true;
            _partSelectContainer.visible = false;
         }
      }
      
      public function getBadgeSettings() : Array
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc1_:Array = [];
         for each(var _loc4_ in _layers)
         {
            _loc2_ = getLayerPartId(_loc4_.layerOptions);
            if(_loc2_ >= 0)
            {
               _loc3_ = getLayerColorId(_loc4_.layerOptions);
               if(_loc3_ >= 0)
               {
                  _loc1_.push(_loc2_);
                  _loc1_.push(_loc3_);
                  _loc1_.push(_loc4_.layerOptions.position);
               }
            }
         }
         return _loc1_;
      }
      
      public function get primaryColorIndex() : int
      {
         if(_layers == null)
         {
            return 0;
         }
         var _loc1_:int = 0;
         for each(var _loc2_ in _layers)
         {
            if(!(getLayerPartId(_loc2_.layerOptions) < 0 || getLayerColorId(_loc2_.layerOptions) < 0))
            {
               _loc1_ = _loc2_.layerOptions.colorIndex;
            }
         }
         return _loc1_;
      }
      
      public function get secondaryColorIndex() : int
      {
         if(_layers != null)
         {
            return _layers[0].layerOptions.colorIndex;
         }
         return 0;
      }
      
      public function getBadgeBitmap() : BitmapData
      {
         var _loc1_:BitmapData = new BitmapData(BadgeEditorPartItem.IMAGE_WIDTH,BadgeEditorPartItem.IMAGE_HEIGHT,true,15329761);
         for each(var _loc2_ in _badgePreviewImages)
         {
            if(_loc2_.visible)
            {
               _loc1_.copyPixels(_loc2_.bitmap,_loc1_.rect,new Point(),null,null,true);
            }
         }
         return _loc1_;
      }
      
      private function getLayerPartId(param1:BadgeLayerOptions) : int
      {
         if(param1.partIndex < 0)
         {
            return -1;
         }
         if(param1.layerIndex == BadgeLayerCtrl.BASE_LAYER_INDEX)
         {
            if(param1.partIndex >= UnknownVarFromBadgeEditorCtrl_HabboGroupsManager_1.guildEditorData.baseParts.length)
            {
               return -1;
            }
            return UnknownVarFromBadgeEditorCtrl_HabboGroupsManager_1.guildEditorData.baseParts[param1.partIndex].id;
         }
         if(param1.partIndex >= UnknownVarFromBadgeEditorCtrl_HabboGroupsManager_1.guildEditorData.layerParts.length)
         {
            return -1;
         }
         return UnknownVarFromBadgeEditorCtrl_HabboGroupsManager_1.guildEditorData.layerParts[param1.partIndex].id;
      }
      
      private function getLayerColorId(param1:BadgeLayerOptions) : int
      {
         if(param1.colorIndex < 0 || param1.colorIndex >= UnknownVarFromBadgeEditorCtrl_HabboGroupsManager_1.guildEditorData.badgeColors.length)
         {
            return -1;
         }
         return UnknownVarFromBadgeEditorCtrl_HabboGroupsManager_1.guildEditorData.badgeColors[param1.colorIndex].id;
      }
   }
}

