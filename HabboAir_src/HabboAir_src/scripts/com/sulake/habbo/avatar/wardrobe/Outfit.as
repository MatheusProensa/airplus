package com.sulake.habbo.avatar.wardrobe
{
   import com.sulake.habbo.avatar.HabboAvatarEditor;
   import com.sulake.habbo.avatar.IAvatarImage_2;
   import com.sulake.habbo.avatar.IOutfit;
   import com.sulake.habbo.avatar.UnknownIHabboAvatar1;
   import flash.display.BitmapData;
   
   public class Outfit implements IOutfit, UnknownIHabboAvatar1
   {
      private var UnknownVarFromOutfit_HabboAvatarEditor_1:HabboAvatarEditor;
      
      private var _figure:String;
      
      private var _gender:String;
      
      private var _view:OutfitView;
      
      private var _disposed:Boolean;
      
      public function Outfit(param1:HabboAvatarEditor, param2:String, param3:String)
      {
         super();
         UnknownVarFromOutfit_HabboAvatarEditor_1 = param1;
         _view = new OutfitView(param1.manager.windowManager,param1.manager.assets,param2 != "");
         switch(param3)
         {
            case "M":
            case "m":
            case "M":
               param3 = "M";
               break;
            case "F":
            case "f":
            case "F":
               param3 = "F";
         }
         _figure = param2;
         _gender = param3;
         update();
      }
      
      public function dispose() : void
      {
         if(_view)
         {
            _view.dispose();
            _view = null;
         }
         _figure = null;
         _gender = null;
         _disposed = true;
         UnknownVarFromOutfit_HabboAvatarEditor_1 = null;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function update() : void
      {
         var _loc1_:BitmapData = null;
         var _loc3_:Boolean = UnknownVarFromOutfit_HabboAvatarEditor_1.manager.getBoolean("zoom.enabled");
         var _loc2_:IAvatarImage_2 = UnknownVarFromOutfit_HabboAvatarEditor_1.manager.avatarRenderManager.createAvatarImage(figure,_loc3_ ? "h" : "sh",_gender,this);
         if(_loc2_)
         {
            _loc2_.setDirection("full",4);
            _loc1_ = _loc2_.getImage("full",true,_loc3_ ? 0.5 : 1);
            if(_view && _loc1_)
            {
               _view.update(_loc1_);
            }
            _loc2_.dispose();
         }
      }
      
      public function get figure() : String
      {
         return _figure;
      }
      
      public function get gender() : String
      {
         return _gender;
      }
      
      public function get view() : OutfitView
      {
         return _view;
      }
      
      public function avatarImageReady(param1:String) : void
      {
         update();
      }
   }
}

