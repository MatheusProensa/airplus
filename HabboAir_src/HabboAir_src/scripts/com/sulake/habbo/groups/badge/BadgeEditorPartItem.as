package com.sulake.habbo.groups.badge
{
   import com.sulake.core.assets.IResourceManager;
   import com.sulake.core.assets.ISoundAsset;
   import com.sulake.core.assets.UnknownICoreAssets1;
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.habbo.communication.messages.incoming.users.BadgePartData;
   import com.sulake.habbo.communication.messages.incoming.users.GuildColorData;
   import com.sulake.habbo.groups.HabboGroupsManager;
   import flash.display.BitmapData;
   import flash.geom.ColorTransform;
   import flash.geom.Point;
   
   public class BadgeEditorPartItem implements IComponentInterfaceQueue, UnknownICoreAssets1
   {
      public static var BASE_PART:int = 0;
      
      public static var LAYER_PART:int = 1;
      
      public static var IMAGE_WIDTH:Number = 39;
      
      public static var IMAGE_HEIGHT:Number = 39;
      
      public static var CELL_WIDTH:Number = 13;
      
      public static var CELL_HEIGHT:Number = 13;
      
      private var UnknownVarFromBadgeEditorPartItem_HabboGroupsManager_1:HabboGroupsManager;
      
      private var UnknownVarFromBadgeEditorPartItem_BadgeSelectPartCtrl_1:BadgeSelectPartCtrl;
      
      private var _partIndex:int;
      
      private var UnknownVarFromBadgeEditorPartItem_Int_1:int;
      
      private var UnknownVarFromBadgeEditorPartItem_String_1:String;
      
      private var _disposed:Boolean;
      
      private var _fileName:String;
      
      private var _maskFileName:String;
      
      private var UnknownVarFromBadgeEditorPartItem_BitmapData_1:BitmapData;
      
      private var UnknownVarFromBadgeEditorPartItem_BitmapData_2:BitmapData;
      
      private var _composite:BitmapData;
      
      private var UnknownVarFromBadgeEditorPartItem_ColorTransform_1:ColorTransform = new ColorTransform(1,1,1);
      
      private var UnknownVarFromBadgeEditorPartItem_Boolean_1:Boolean = false;
      
      private var _isLoaded:Boolean = false;
      
      private var UnknownVarFromBadgeEditorPartItem_Boolean_2:Boolean = false;
      
      public function BadgeEditorPartItem(param1:HabboGroupsManager, param2:BadgeSelectPartCtrl, param3:int, param4:int, param5:BadgePartData = null)
      {
         super();
         _partIndex = param3;
         UnknownVarFromBadgeEditorPartItem_HabboGroupsManager_1 = param1;
         UnknownVarFromBadgeEditorPartItem_BadgeSelectPartCtrl_1 = param2;
         UnknownVarFromBadgeEditorPartItem_Int_1 = param4;
         UnknownVarFromBadgeEditorPartItem_String_1 = UnknownVarFromBadgeEditorPartItem_HabboGroupsManager_1.getProperty("image.library.badgepart.url");
         _composite = new BitmapData(IMAGE_WIDTH,IMAGE_HEIGHT);
         if(param5 == null)
         {
            _isLoaded = true;
            UnknownVarFromBadgeEditorPartItem_Boolean_2 = true;
            UnknownVarFromBadgeEditorPartItem_BitmapData_1 = UnknownVarFromBadgeEditorPartItem_HabboGroupsManager_1.getButtonImage("badge_part_empty");
         }
         else
         {
            _fileName = param5.fileName.replace(".gif","").replace(".png","");
            _maskFileName = param5.maskFileName.replace(".gif","").replace(".png","");
            UnknownVarFromBadgeEditorPartItem_Boolean_1 = _maskFileName.length > 0;
            _composite = new BitmapData(IMAGE_WIDTH,IMAGE_HEIGHT);
            _fileName = UnknownVarFromBadgeEditorPartItem_String_1 + "badgepart_" + _fileName + ".png";
            _maskFileName = UnknownVarFromBadgeEditorPartItem_String_1 + "badgepart_" + _maskFileName + ".png";
            UnknownVarFromBadgeEditorPartItem_HabboGroupsManager_1.windowManager.resourceManager.retrieveAsset(_fileName,this);
            UnknownVarFromBadgeEditorPartItem_HabboGroupsManager_1.windowManager.resourceManager.retrieveAsset(_maskFileName,this);
         }
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function get partIndex() : int
      {
         return _partIndex;
      }
      
      public function receiveAsset(param1:ISoundAsset, param2:String) : void
      {
         var _loc3_:IResourceManager = UnknownVarFromBadgeEditorPartItem_HabboGroupsManager_1.windowManager.resourceManager;
         if(_loc3_.isSameAsset(_fileName,param2))
         {
            UnknownVarFromBadgeEditorPartItem_BitmapData_1 = param1.content as BitmapData;
         }
         if(_loc3_.isSameAsset(_maskFileName,param2))
         {
            UnknownVarFromBadgeEditorPartItem_BitmapData_2 = param1.content as BitmapData;
         }
         checkIsImageLoaded();
      }
      
      public function dispose() : void
      {
         if(!disposed)
         {
            if(UnknownVarFromBadgeEditorPartItem_BitmapData_1)
            {
               UnknownVarFromBadgeEditorPartItem_BitmapData_1.dispose();
               UnknownVarFromBadgeEditorPartItem_BitmapData_1 = null;
            }
            if(UnknownVarFromBadgeEditorPartItem_BitmapData_2)
            {
               UnknownVarFromBadgeEditorPartItem_BitmapData_2.dispose();
               UnknownVarFromBadgeEditorPartItem_BitmapData_2 = null;
            }
            if(_composite)
            {
               _composite.dispose();
               _composite = null;
            }
            _fileName = null;
            _maskFileName = null;
            UnknownVarFromBadgeEditorPartItem_ColorTransform_1 = null;
            UnknownVarFromBadgeEditorPartItem_BadgeSelectPartCtrl_1 = null;
            UnknownVarFromBadgeEditorPartItem_HabboGroupsManager_1 = null;
            _disposed = true;
         }
      }
      
      private function checkIsImageLoaded() : void
      {
         if(UnknownVarFromBadgeEditorPartItem_BitmapData_1 == null)
         {
            return;
         }
         if(UnknownVarFromBadgeEditorPartItem_Boolean_1 && UnknownVarFromBadgeEditorPartItem_BitmapData_2 == null)
         {
            return;
         }
         _isLoaded = true;
         if(UnknownVarFromBadgeEditorPartItem_Int_1 == BASE_PART)
         {
            UnknownVarFromBadgeEditorPartItem_BadgeSelectPartCtrl_1.onBaseImageLoaded(this);
         }
         else
         {
            UnknownVarFromBadgeEditorPartItem_BadgeSelectPartCtrl_1.onLayerImageLoaded(this);
         }
      }
      
      public function getComposite(param1:BadgeLayerOptions) : BitmapData
      {
         if(!_isLoaded)
         {
            return null;
         }
         if(UnknownVarFromBadgeEditorPartItem_Boolean_2)
         {
            return UnknownVarFromBadgeEditorPartItem_BitmapData_1;
         }
         var _loc2_:GuildColorData = UnknownVarFromBadgeEditorPartItem_HabboGroupsManager_1.guildEditorData.badgeColors[param1.colorIndex] as GuildColorData;
         UnknownVarFromBadgeEditorPartItem_ColorTransform_1.redMultiplier = _loc2_.red / 255;
         UnknownVarFromBadgeEditorPartItem_ColorTransform_1.greenMultiplier = _loc2_.green / 255;
         UnknownVarFromBadgeEditorPartItem_ColorTransform_1.blueMultiplier = _loc2_.blue / 255;
         var _loc3_:Point = getPosition(param1);
         _composite.dispose();
         _composite = new BitmapData(IMAGE_WIDTH,IMAGE_HEIGHT,true,0);
         _composite.copyPixels(UnknownVarFromBadgeEditorPartItem_BitmapData_1,UnknownVarFromBadgeEditorPartItem_BitmapData_1.rect,_loc3_);
         _composite.colorTransform(_composite.rect,UnknownVarFromBadgeEditorPartItem_ColorTransform_1);
         if(UnknownVarFromBadgeEditorPartItem_Boolean_1)
         {
            _composite.copyPixels(UnknownVarFromBadgeEditorPartItem_BitmapData_2,UnknownVarFromBadgeEditorPartItem_BitmapData_2.rect,_loc3_,null,null,true);
         }
         return _composite;
      }
      
      private function getPosition(param1:BadgeLayerOptions) : Point
      {
         var _loc2_:Number = CELL_WIDTH * param1.gridX + CELL_WIDTH / 2 - UnknownVarFromBadgeEditorPartItem_BitmapData_1.width / 2;
         var _loc3_:Number = CELL_HEIGHT * param1.gridY + CELL_HEIGHT / 2 - UnknownVarFromBadgeEditorPartItem_BitmapData_1.height / 2;
         if(_loc2_ < 0)
         {
            _loc2_ = 0;
         }
         if(_loc2_ + UnknownVarFromBadgeEditorPartItem_BitmapData_1.width > IMAGE_WIDTH)
         {
            _loc2_ = IMAGE_WIDTH - UnknownVarFromBadgeEditorPartItem_BitmapData_1.width;
         }
         if(_loc3_ < 0)
         {
            _loc3_ = 0;
         }
         if(_loc3_ + UnknownVarFromBadgeEditorPartItem_BitmapData_1.height > IMAGE_HEIGHT)
         {
            _loc3_ = IMAGE_HEIGHT - UnknownVarFromBadgeEditorPartItem_BitmapData_1.height;
         }
         return new Point(Math.floor(_loc2_),Math.floor(_loc3_));
      }
   }
}

