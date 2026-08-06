package com.sulake.habbo.avatar.effects
{
   import com.sulake.core.assets.IAssetLibraryCollection;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IBitmapWrapperController;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.avatar.UnknownIHabboAvatar3;
   import com.sulake.habbo.window.IHabboWindowManagerComponent;
   import flash.display.BitmapData;
   import flash.geom.Rectangle;
   
   public class AvatarEditorGridItemEffect
   {
      private var _window:IWindowController_1;
      
      private var UnknownVarFromAvatarEditorGridItemEffect_IWindowModel_1:IWindowModel;
      
      private var UnknownVarFromAvatarEditorGridItemEffect_Boolean_1:Boolean = false;
      
      private var UnknownVarFromAvatarEditorGridItemEffect_UnknownIHabboAvatar3_1:UnknownIHabboAvatar3;
      
      public function AvatarEditorGridItemEffect(param1:UnknownIHabboAvatar3, param2:IHabboWindowManagerComponent, param3:IAssetLibraryCollection)
      {
         super();
         _window = IWindowController_1(param2.buildFromXML(param3.getAssetByName("avatar_editor_effect_griditem_xml").content as XML));
         UnknownVarFromAvatarEditorGridItemEffect_IWindowModel_1 = _window.findChildByTag("BG_COLOR");
         UnknownVarFromAvatarEditorGridItemEffect_UnknownIHabboAvatar3_1 = param1;
         if(param1 != null)
         {
            bitmap = param1.icon;
            amount = param1.amountInInventory;
            if(param1.isPermanent)
            {
               setSecondsLeft(param1.duration,param1.duration);
            }
            else if(param1.isActive)
            {
               setSecondsLeft(param1.secondsLeft,param1.duration);
            }
         }
         else
         {
            bitmap = BitmapData(param2.assets.getAssetByName("avatar_editor_generic_remove_selection").content);
            amount = 1;
         }
         selected = false;
         _window.addEventListener("WME_OVER",onMouseOver);
         _window.addEventListener("WME_OUT",onMousetOut);
      }
      
      public function get effectType() : int
      {
         return UnknownVarFromAvatarEditorGridItemEffect_UnknownIHabboAvatar3_1 != null ? UnknownVarFromAvatarEditorGridItemEffect_UnknownIHabboAvatar3_1.type : -1;
      }
      
      private function onMousetOut(param1:WindowMouseEvent) : void
      {
         if(!UnknownVarFromAvatarEditorGridItemEffect_Boolean_1)
         {
            UnknownVarFromAvatarEditorGridItemEffect_IWindowModel_1.visible = false;
         }
         UnknownVarFromAvatarEditorGridItemEffect_IWindowModel_1.blend = 1;
      }
      
      private function onMouseOver(param1:WindowMouseEvent) : void
      {
         if(!UnknownVarFromAvatarEditorGridItemEffect_Boolean_1)
         {
            UnknownVarFromAvatarEditorGridItemEffect_IWindowModel_1.visible = true;
            UnknownVarFromAvatarEditorGridItemEffect_IWindowModel_1.blend = 0.5;
         }
      }
      
      public function get window() : IWindowModel
      {
         return _window;
      }
      
      public function set selected(param1:Boolean) : void
      {
         UnknownVarFromAvatarEditorGridItemEffect_Boolean_1 = param1;
         UnknownVarFromAvatarEditorGridItemEffect_IWindowModel_1.visible = UnknownVarFromAvatarEditorGridItemEffect_Boolean_1;
         UnknownVarFromAvatarEditorGridItemEffect_IWindowModel_1.blend = 1;
      }
      
      private function set bitmap(param1:BitmapData) : void
      {
         IBitmapWrapperController(_window.findChildByName("bitmap")).bitmap = param1;
      }
      
      private function set amount(param1:int) : void
      {
         var _loc2_:IWindowController_1 = IWindowController_1(_window.findChildByName("effect_amount_bg1"));
         var _loc3_:ITextWindow = ITextWindow(_window.findChildByName("effect_amount"));
         _loc2_.visible = param1 > 1;
         _loc3_.text = param1.toString();
      }
      
      private function setSecondsLeft(param1:int, param2:int) : void
      {
         _window.findChildByName("duration_container").visible = true;
         var _loc5_:IBitmapWrapperController = IBitmapWrapperController(_window.findChildByName("progress_bar"));
         var _loc3_:BitmapData = new BitmapData(_loc5_.width,_loc5_.height,false,0);
         var _loc4_:Rectangle = new Rectangle(0,0,int(_loc3_.width * (param1 / param2)),_loc3_.height);
         _loc3_.fillRect(_loc4_,2146080);
         _loc5_.bitmap = _loc3_;
      }
   }
}

