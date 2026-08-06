package com.sulake.habbo.groups.badge
{
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IBitmapWrapperController;
   import com.sulake.core.window.components.UnknownICoreWindowComponents6;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.communication.messages.incoming.users.BadgePartData;
   import com.sulake.habbo.groups.HabboGroupsManager;
   import flash.display.BitmapData;
   import flash.geom.Point;
   
   public class BadgeSelectPartCtrl implements IComponentInterfaceQueue
   {
      private var UnknownVarFromBadgeSelectPartCtrl_HabboGroupsManager_1:HabboGroupsManager;
      
      private var UnknownVarFromBadgeSelectPartCtrl_BadgeEditorCtrl_1:BadgeEditorCtrl;
      
      private var UnknownVarFromBadgeSelectPartCtrl_Vector_1:Vector.<BadgeEditorPartItem>;
      
      private var UnknownVarFromBadgeSelectPartCtrl_Vector_2:Vector.<BadgeEditorPartItem>;
      
      private var _layerOptions:BadgeLayerOptions;
      
      private var UnknownVarFromBadgeSelectPartCtrl_IWindowController_1_1:IWindowController_1;
      
      private var UnknownVarFromBadgeSelectPartCtrl_IBitmapWrapperController_1:IBitmapWrapperController;
      
      private var _disposed:Boolean = false;
      
      public function BadgeSelectPartCtrl(param1:HabboGroupsManager, param2:BadgeEditorCtrl)
      {
         super();
         UnknownVarFromBadgeSelectPartCtrl_HabboGroupsManager_1 = param1;
         UnknownVarFromBadgeSelectPartCtrl_BadgeEditorCtrl_1 = param2;
      }
      
      public function get layerOptions() : BadgeLayerOptions
      {
         return _layerOptions;
      }
      
      public function set layerOptions(param1:BadgeLayerOptions) : void
      {
         _layerOptions = param1;
      }
      
      public function dispose() : void
      {
         var _loc1_:* = null;
         if(!_disposed)
         {
            if(UnknownVarFromBadgeSelectPartCtrl_BadgeEditorCtrl_1.partSelectGrid != null && UnknownVarFromBadgeSelectPartCtrl_BadgeEditorCtrl_1.partSelectGrid.numGridItems > 0)
            {
               UnknownVarFromBadgeSelectPartCtrl_BadgeEditorCtrl_1.partSelectGrid.destroyGridItems();
            }
            if(UnknownVarFromBadgeSelectPartCtrl_Vector_2)
            {
               for each(_loc1_ in UnknownVarFromBadgeSelectPartCtrl_Vector_2)
               {
                  _loc1_.dispose();
               }
               UnknownVarFromBadgeSelectPartCtrl_Vector_2 = null;
            }
            if(UnknownVarFromBadgeSelectPartCtrl_Vector_1)
            {
               for each(_loc1_ in UnknownVarFromBadgeSelectPartCtrl_Vector_1)
               {
                  _loc1_.dispose();
               }
               UnknownVarFromBadgeSelectPartCtrl_Vector_1 = null;
            }
            _layerOptions = null;
            UnknownVarFromBadgeSelectPartCtrl_IBitmapWrapperController_1 = null;
            UnknownVarFromBadgeSelectPartCtrl_IWindowController_1_1 = null;
            UnknownVarFromBadgeSelectPartCtrl_BadgeEditorCtrl_1 = null;
            UnknownVarFromBadgeSelectPartCtrl_HabboGroupsManager_1 = null;
            _disposed = true;
         }
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function getSelectedPartIndex() : int
      {
         var _loc1_:int = -1;
         if(_layerOptions != null && UnknownVarFromBadgeSelectPartCtrl_BadgeEditorCtrl_1.partSelectGrid != null && UnknownVarFromBadgeSelectPartCtrl_IWindowController_1_1 != null)
         {
            _loc1_ = UnknownVarFromBadgeSelectPartCtrl_BadgeEditorCtrl_1.partSelectGrid.getGridItemIndex(UnknownVarFromBadgeSelectPartCtrl_IWindowController_1_1);
            if(_loc1_ != -1 && _layerOptions.layerIndex != BadgeLayerCtrl.BASE_LAYER_INDEX)
            {
               _loc1_ -= 1;
            }
         }
         return _loc1_;
      }
      
      public function loadData() : void
      {
         var _loc1_:* = null;
         if(UnknownVarFromBadgeSelectPartCtrl_Vector_2 != null || UnknownVarFromBadgeSelectPartCtrl_Vector_1 != null)
         {
            return;
         }
         UnknownVarFromBadgeSelectPartCtrl_Vector_2 = new Vector.<BadgeEditorPartItem>();
         for each(_loc1_ in UnknownVarFromBadgeSelectPartCtrl_HabboGroupsManager_1.guildEditorData.baseParts)
         {
            UnknownVarFromBadgeSelectPartCtrl_Vector_2.push(new BadgeEditorPartItem(UnknownVarFromBadgeSelectPartCtrl_HabboGroupsManager_1,this,UnknownVarFromBadgeSelectPartCtrl_Vector_2.length,BadgeEditorPartItem.BASE_PART,_loc1_));
         }
         UnknownVarFromBadgeSelectPartCtrl_Vector_1 = new Vector.<BadgeEditorPartItem>();
         UnknownVarFromBadgeSelectPartCtrl_Vector_1.push(new BadgeEditorPartItem(UnknownVarFromBadgeSelectPartCtrl_HabboGroupsManager_1,this,-1,BadgeEditorPartItem.LAYER_PART));
         for each(_loc1_ in UnknownVarFromBadgeSelectPartCtrl_HabboGroupsManager_1.guildEditorData.layerParts)
         {
            UnknownVarFromBadgeSelectPartCtrl_Vector_1.push(new BadgeEditorPartItem(UnknownVarFromBadgeSelectPartCtrl_HabboGroupsManager_1,this,UnknownVarFromBadgeSelectPartCtrl_Vector_1.length - 1,BadgeEditorPartItem.LAYER_PART,_loc1_));
         }
      }
      
      public function updateGrid() : void
      {
         var _loc1_:* = null;
         UnknownVarFromBadgeSelectPartCtrl_IWindowController_1_1 = null;
         UnknownVarFromBadgeSelectPartCtrl_IBitmapWrapperController_1 = null;
         _layerOptions = UnknownVarFromBadgeSelectPartCtrl_BadgeEditorCtrl_1.currentLayerOptions.clone();
         UnknownVarFromBadgeSelectPartCtrl_BadgeEditorCtrl_1.partSelectGrid.destroyGridItems();
         if(_layerOptions.layerIndex == BadgeLayerCtrl.BASE_LAYER_INDEX)
         {
            for each(_loc1_ in UnknownVarFromBadgeSelectPartCtrl_Vector_2)
            {
               UnknownVarFromBadgeSelectPartCtrl_BadgeEditorCtrl_1.partSelectGrid.addGridItem(createGridItem(_loc1_));
            }
         }
         else
         {
            for each(_loc1_ in UnknownVarFromBadgeSelectPartCtrl_Vector_1)
            {
               UnknownVarFromBadgeSelectPartCtrl_BadgeEditorCtrl_1.partSelectGrid.addGridItem(createGridItem(_loc1_));
            }
         }
      }
      
      private function createGridItem(param1:BadgeEditorPartItem) : IWindowController_1
      {
         var _loc2_:IWindowController_1 = UnknownVarFromBadgeSelectPartCtrl_HabboGroupsManager_1.getXmlWindow("badge_part_item") as IWindowController_1;
         _loc2_.procedure = onPartMouseEvent;
         setGridItemImage(_loc2_,param1);
         return _loc2_;
      }
      
      public function onBaseImageLoaded(param1:BadgeEditorPartItem) : void
      {
         var _loc2_:IWindowController_1 = null;
         if(_layerOptions != null && _layerOptions.layerIndex == BadgeLayerCtrl.BASE_LAYER_INDEX && Boolean(UnknownVarFromBadgeSelectPartCtrl_BadgeEditorCtrl_1.partSelectContainer.visible))
         {
            _loc2_ = UnknownVarFromBadgeSelectPartCtrl_BadgeEditorCtrl_1.partSelectGrid.getGridItemAt(param1.partIndex) as IWindowController_1;
            setGridItemImage(_loc2_,param1);
         }
      }
      
      public function onLayerImageLoaded(param1:BadgeEditorPartItem) : void
      {
         var _loc2_:IWindowController_1 = null;
         if(_layerOptions != null && _layerOptions.layerIndex != BadgeLayerCtrl.BASE_LAYER_INDEX && Boolean(UnknownVarFromBadgeSelectPartCtrl_BadgeEditorCtrl_1.partSelectContainer.visible))
         {
            _loc2_ = UnknownVarFromBadgeSelectPartCtrl_BadgeEditorCtrl_1.partSelectGrid.getGridItemAt(param1.partIndex + 1) as IWindowController_1;
            setGridItemImage(_loc2_,param1);
         }
      }
      
      private function setGridItemImage(param1:IWindowController_1, param2:BadgeEditorPartItem) : void
      {
         var _loc5_:IBitmapWrapperController = null;
         var _loc4_:BitmapData = param2.getComposite(_layerOptions);
         if(_loc4_ != null)
         {
            _loc5_ = param1.findChildByName("part") as IBitmapWrapperController;
            _loc5_.bitmap = new BitmapData(_loc4_.width,_loc4_.height);
            _loc5_.bitmap.copyPixels(_loc4_,_loc4_.rect,new Point());
         }
         var _loc3_:IBitmapWrapperController = param1.findChildByName("selected") as IBitmapWrapperController;
         _loc3_.bitmap = UnknownVarFromBadgeSelectPartCtrl_HabboGroupsManager_1.getButtonImage("badge_part_picker");
         if(param2.partIndex == _layerOptions.partIndex)
         {
            _loc3_.visible = true;
            UnknownVarFromBadgeSelectPartCtrl_IBitmapWrapperController_1 = _loc3_;
         }
         else
         {
            _loc3_.visible = false;
         }
      }
      
      private function onPartMouseEvent(param1:WindowEvent, param2:IWindowModel) : void
      {
         var _loc3_:UnknownICoreWindowComponents6 = null;
         var _loc4_:IWindowController_1 = null;
         if(param1.type == "WME_OVER")
         {
            if(UnknownVarFromBadgeSelectPartCtrl_IWindowController_1_1 != param2)
            {
               if(UnknownVarFromBadgeSelectPartCtrl_IWindowController_1_1 != null)
               {
                  _loc3_ = UnknownVarFromBadgeSelectPartCtrl_IWindowController_1_1.findChildByName("background") as UnknownICoreWindowComponents6;
                  if(_loc3_ != null)
                  {
                     _loc3_.color = 15329761;
                  }
               }
               UnknownVarFromBadgeSelectPartCtrl_IWindowController_1_1 = param2 as IWindowController_1;
               if(UnknownVarFromBadgeSelectPartCtrl_IWindowController_1_1 != null)
               {
                  _loc3_ = UnknownVarFromBadgeSelectPartCtrl_IWindowController_1_1.findChildByName("background") as UnknownICoreWindowComponents6;
                  if(_loc3_ != null)
                  {
                     _loc3_.color = 14210761;
                  }
                  _layerOptions.partIndex = getSelectedPartIndex();
                  UnknownVarFromBadgeSelectPartCtrl_BadgeEditorCtrl_1.onPartHover(this);
               }
            }
         }
         if(param1.type == "WME_CLICK")
         {
            if(UnknownVarFromBadgeSelectPartCtrl_IBitmapWrapperController_1 != null)
            {
               UnknownVarFromBadgeSelectPartCtrl_IBitmapWrapperController_1.visible = false;
            }
            _loc4_ = param2 as IWindowController_1;
            if(_loc4_ != null)
            {
               UnknownVarFromBadgeSelectPartCtrl_IBitmapWrapperController_1 = _loc4_.findChildByName("selected") as IBitmapWrapperController;
               UnknownVarFromBadgeSelectPartCtrl_IBitmapWrapperController_1.visible = true;
            }
            UnknownVarFromBadgeSelectPartCtrl_BadgeEditorCtrl_1.onPartSelected(this);
         }
      }
      
      public function getPartItemImage(param1:BadgeLayerOptions) : BitmapData
      {
         if(param1 == null || param1.partIndex < 0)
         {
            return null;
         }
         if(param1.layerIndex == BadgeLayerCtrl.BASE_LAYER_INDEX)
         {
            if(UnknownVarFromBadgeSelectPartCtrl_Vector_2 != null && param1.partIndex < UnknownVarFromBadgeSelectPartCtrl_Vector_2.length)
            {
               return UnknownVarFromBadgeSelectPartCtrl_Vector_2[param1.partIndex].getComposite(param1);
            }
         }
         else if(UnknownVarFromBadgeSelectPartCtrl_Vector_1 != null && param1.partIndex + 1 < UnknownVarFromBadgeSelectPartCtrl_Vector_1.length)
         {
            return UnknownVarFromBadgeSelectPartCtrl_Vector_1[param1.partIndex + 1].getComposite(param1);
         }
         return null;
      }
   }
}

