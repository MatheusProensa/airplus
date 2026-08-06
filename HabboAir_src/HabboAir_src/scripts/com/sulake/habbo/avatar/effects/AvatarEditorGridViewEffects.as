package com.sulake.habbo.avatar.effects
{
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IItemGridWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.avatar.UnknownIHabboAvatar3;
   import com.sulake.habbo.avatar.common.*;
   
   public class AvatarEditorGridViewEffects implements IAvatarEditorGridView
   {
      private var _window:IWindowController_1;
      
      private var _firstView:Boolean = true;
      
      private var UnknownVarFromAvatarEditorGridViewEffects_ICategoryBaseModel_1_1:ICategoryBaseModel_1;
      
      private var UnknownVarFromAvatarEditorGridViewEffects_String_1:String;
      
      private var UnknownVarFromAvatarEditorGridViewEffects_IItemGridWindow_1:IItemGridWindow;
      
      private var _effectItems:Vector.<AvatarEditorGridItemEffect>;
      
      private var UnknownVarFromAvatarEditorGridViewEffects_IWindowModel_1:IWindowModel;
      
      private var UnknownVarFromAvatarEditorGridViewEffects_IWindowModel_2:IWindowModel;
      
      public function AvatarEditorGridViewEffects(param1:IWindowController_1)
      {
         super();
         _window = param1;
         UnknownVarFromAvatarEditorGridViewEffects_IItemGridWindow_1 = _window.findChildByName("thumbs") as IItemGridWindow;
         UnknownVarFromAvatarEditorGridViewEffects_IWindowModel_1 = _window.findChildByName("content_notification");
         UnknownVarFromAvatarEditorGridViewEffects_IWindowModel_2 = _window.findChildByName("content_title");
      }
      
      public function dispose() : void
      {
         if(UnknownVarFromAvatarEditorGridViewEffects_IItemGridWindow_1)
         {
            UnknownVarFromAvatarEditorGridViewEffects_IItemGridWindow_1.dispose();
            UnknownVarFromAvatarEditorGridViewEffects_IItemGridWindow_1 = null;
         }
         UnknownVarFromAvatarEditorGridViewEffects_ICategoryBaseModel_1_1 = null;
         if(_window)
         {
            _window.dispose();
            _window = null;
         }
      }
      
      public function get window() : IWindowController_1
      {
         return _window;
      }
      
      public function initFromList(param1:ICategoryBaseModel_1, param2:String) : void
      {
         var _loc5_:AvatarEditorGridItemEffect = null;
         UnknownVarFromAvatarEditorGridViewEffects_ICategoryBaseModel_1_1 = param1;
         UnknownVarFromAvatarEditorGridViewEffects_String_1 = param2;
         _window.visible = true;
         var _loc3_:Array = EffectsModel(UnknownVarFromAvatarEditorGridViewEffects_ICategoryBaseModel_1_1).effects;
         UnknownVarFromAvatarEditorGridViewEffects_IItemGridWindow_1.removeGridItems();
         _effectItems = new Vector.<AvatarEditorGridItemEffect>();
         if(_loc3_.length == 0)
         {
            UnknownVarFromAvatarEditorGridViewEffects_IWindowModel_2.visible = true;
            UnknownVarFromAvatarEditorGridViewEffects_IWindowModel_1.visible = true;
         }
         else
         {
            UnknownVarFromAvatarEditorGridViewEffects_IWindowModel_1.visible = false;
            UnknownVarFromAvatarEditorGridViewEffects_IWindowModel_2.visible = false;
            _loc5_ = new AvatarEditorGridItemEffect(null,UnknownVarFromAvatarEditorGridViewEffects_ICategoryBaseModel_1_1.controller.manager.windowManager,UnknownVarFromAvatarEditorGridViewEffects_ICategoryBaseModel_1_1.controller.manager.assets);
            addGridItem(_loc5_);
            for each(var _loc4_ in _loc3_)
            {
               _loc5_ = new AvatarEditorGridItemEffect(_loc4_,UnknownVarFromAvatarEditorGridViewEffects_ICategoryBaseModel_1_1.controller.manager.windowManager,UnknownVarFromAvatarEditorGridViewEffects_ICategoryBaseModel_1_1.controller.manager.assets);
               addGridItem(_loc5_);
            }
         }
         showPalettes(0);
         _firstView = false;
      }
      
      private function addGridItem(param1:AvatarEditorGridItemEffect) : void
      {
         param1.window.procedure = partEventProc;
         _effectItems.push(param1);
         UnknownVarFromAvatarEditorGridViewEffects_IItemGridWindow_1.addGridItem(param1.window);
      }
      
      public function showPalettes(param1:int) : void
      {
         var _loc3_:IWindowModel = _window.findChildByName("palette0");
         var _loc2_:IWindowModel = _window.findChildByName("palette1");
         _loc3_.visible = false;
         _loc2_.visible = false;
      }
      
      public function get firstView() : Boolean
      {
         return _firstView;
      }
      
      public function updateSelection(param1:int, param2:Boolean) : void
      {
         if(param1 >= 0 && param1 < _effectItems.length)
         {
            _effectItems[param1].selected = param2;
         }
      }
      
      public function getGridIndex(param1:int) : int
      {
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < _effectItems.length)
         {
            if(_effectItems[_loc2_].effectType == param1)
            {
               return _loc2_;
            }
            _loc2_++;
         }
         return -1;
      }
      
      private function partEventProc(param1:WindowEvent, param2:IWindowModel) : void
      {
         var _loc3_:int = 0;
         if(param1.type == "WME_DOWN")
         {
            _loc3_ = UnknownVarFromAvatarEditorGridViewEffects_IItemGridWindow_1.getGridItemIndex(param1.window);
            UnknownVarFromAvatarEditorGridViewEffects_ICategoryBaseModel_1_1.selectPart(UnknownVarFromAvatarEditorGridViewEffects_String_1,_loc3_);
         }
      }
   }
}

