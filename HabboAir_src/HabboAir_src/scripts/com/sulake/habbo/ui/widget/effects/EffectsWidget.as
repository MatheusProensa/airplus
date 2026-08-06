package com.sulake.habbo.ui.widget.effects
{
   import com.sulake.core.assets.IAssetLibraryCollection;
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.utils.Map;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IScrollableListWindow;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.ui.IRoomWidgetHandler;
   import com.sulake.habbo.ui.handler.EffectsWidgetHandler;
   import com.sulake.habbo.ui.widget.RoomWidgetBase;
   import com.sulake.habbo.ui.widget.memenu.UnknownIHabboUiWidgetMemenu1;
   import com.sulake.habbo.window.IHabboWindowManagerComponent;
   import flash.geom.Rectangle;
   
   public class EffectsWidget extends RoomWidgetBase
   {
      private static const LIST_HEIGHT_MAX:int = 320;
      
      private static const LIST_HEIGHT_MIN:int = 48;
      
      private static const TOOLBAR_MARGIN:int = 2;
      
      private var UnknownVarFromEffectsWidget_IWindowController_1_1:IWindowController_1;
      
      private var UnknownVarFromEffectsWidget_IScrollableListWindow_1:IScrollableListWindow;
      
      private var UnknownVarFromEffectsWidget_Map_1:Map;
      
      public function EffectsWidget(param1:IRoomWidgetHandler, param2:IHabboWindowManagerComponent, param3:IAssetLibraryCollection)
      {
         super(param1,param2,param3);
         this.handler.widget = this;
         UnknownVarFromEffectsWidget_Map_1 = new Map();
      }
      
      public function get handler() : EffectsWidgetHandler
      {
         return _widgetHandler as EffectsWidgetHandler;
      }
      
      override public function dispose() : void
      {
         if(disposed)
         {
            return;
         }
         if(UnknownVarFromEffectsWidget_Map_1)
         {
            for each(var _loc1_ in UnknownVarFromEffectsWidget_Map_1)
            {
               _loc1_.dispose();
            }
            UnknownVarFromEffectsWidget_Map_1.dispose();
            UnknownVarFromEffectsWidget_Map_1 = null;
         }
         UnknownVarFromEffectsWidget_IScrollableListWindow_1 = null;
         if(UnknownVarFromEffectsWidget_IWindowController_1_1)
         {
            UnknownVarFromEffectsWidget_IWindowController_1_1.dispose();
            UnknownVarFromEffectsWidget_IWindowController_1_1 = null;
         }
         super.dispose();
      }
      
      public function open() : void
      {
         var _loc2_:XmlAsset = null;
         var _loc1_:Rectangle = null;
         var _loc3_:IWindowModel = null;
         if(!UnknownVarFromEffectsWidget_IWindowController_1_1)
         {
            _loc2_ = assets.getAssetByName("effects_widget") as XmlAsset;
            UnknownVarFromEffectsWidget_IWindowController_1_1 = windowManager.buildFromXML(_loc2_.content as XML) as IWindowController_1;
            _loc1_ = handler.container.toolbar.getRect();
            UnknownVarFromEffectsWidget_IWindowController_1_1.x = _loc1_.right + 2;
            UnknownVarFromEffectsWidget_IWindowController_1_1.y = _loc1_.bottom - UnknownVarFromEffectsWidget_IWindowController_1_1.height;
            UnknownVarFromEffectsWidget_IScrollableListWindow_1 = UnknownVarFromEffectsWidget_IWindowController_1_1.findChildByName("list") as IScrollableListWindow;
            _loc3_ = UnknownVarFromEffectsWidget_IWindowController_1_1.findChildByName("close");
            _loc3_.addEventListener("WME_CLICK",onClose);
         }
         update();
         UnknownVarFromEffectsWidget_IWindowController_1_1.visible = true;
      }
      
      public function update() : void
      {
         var _loc1_:EffectView = null;
         var _loc4_:int = 0;
         var _loc2_:Array = this.handler.container.inventory.getAvatarEffects();
         for each(var _loc3_ in _loc2_)
         {
            _loc1_ = UnknownVarFromEffectsWidget_Map_1.getValue(_loc3_.type) as EffectView;
            if(_loc1_)
            {
               _loc1_.update();
            }
            else
            {
               _loc1_ = new EffectView(this,_loc3_);
               UnknownVarFromEffectsWidget_Map_1.add(_loc3_.type,_loc1_);
               UnknownVarFromEffectsWidget_IScrollableListWindow_1.addListItem(_loc1_.window);
            }
         }
         _loc4_ = UnknownVarFromEffectsWidget_Map_1.length - 1;
         while(_loc4_ >= 0)
         {
            _loc1_ = UnknownVarFromEffectsWidget_Map_1.getWithIndex(_loc4_);
            if(_loc2_.indexOf(_loc1_.effect) == -1)
            {
               UnknownVarFromEffectsWidget_IScrollableListWindow_1.removeListItem(_loc1_.window);
               UnknownVarFromEffectsWidget_Map_1.remove(UnknownVarFromEffectsWidget_Map_1.getKey(_loc4_));
               _loc1_.dispose();
            }
            _loc4_--;
         }
         var _loc5_:int = int(UnknownVarFromEffectsWidget_IScrollableListWindow_1.scrollableRegion.height);
         UnknownVarFromEffectsWidget_IScrollableListWindow_1.height = Math.max(Math.min(_loc5_,320),48);
         UnknownVarFromEffectsWidget_IWindowController_1_1.findChildByName("no_effects").visible = _loc2_.length == 0;
      }
      
      public function selectEffect(param1:int, param2:Boolean) : void
      {
         if(param2)
         {
            handler.container.inventory.setEffectDeselected(param1);
         }
         else
         {
            handler.container.inventory.setEffectSelected(param1);
         }
      }
      
      private function onClose(param1:WindowMouseEvent) : void
      {
         UnknownVarFromEffectsWidget_IWindowController_1_1.visible = false;
      }
   }
}

