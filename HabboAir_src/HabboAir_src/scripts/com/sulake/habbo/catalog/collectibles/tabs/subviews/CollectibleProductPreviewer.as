package com.sulake.habbo.catalog.collectibles.tabs.subviews
{
   import com.sulake.core.window.components.IBitmapWrapperController;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.components.IWidgetWindowController;
   import com.sulake.habbo.avatar.IAvatarRenderManager;
   import com.sulake.habbo.catalog.collectibles.UnknownIHabboCatalogCollectibles1;
   import com.sulake.habbo.room.UnknownHabboRoom1;
   import com.sulake.habbo.window.widgets.IAvatarImageWidget;
   import com.sulake.habbo.window.widgets.IBadgeImageWidget;
   import com.sulake.habbo.window.widgets.IPetImageWidget;
   import flash.display.BitmapData;
   
   public class CollectibleProductPreviewer implements UnknownIHabboCatalogCollectibles1
   {
      private var UnknownVarFromCollectibleProductPreviewer_Number_1:Number;
      
      private var UnknownVarFromCollectibleProductPreviewer_IWidgetWindowController_1:IWidgetWindowController;
      
      private var UnknownVarFromCollectibleProductPreviewer_IWidgetWindowController_2:IWidgetWindowController;
      
      private var UnknownVarFromCollectibleProductPreviewer_IWidgetWindowController_3:IWidgetWindowController;
      
      private var UnknownVarFromCollectibleProductPreviewer_IBitmapWrapperController_1:IBitmapWrapperController;
      
      private var UnknownVarFromCollectibleProductPreviewer_IStaticBitmapWrapperWindow_1:IStaticBitmapWrapperWindow;
      
      private var UnknownVarFromCollectibleProductPreviewer_EffectPreviewer_1:EffectPreviewer;
      
      private var UnknownVarFromCollectibleProductPreviewer_IStaticBitmapWrapperWindow_2:IStaticBitmapWrapperWindow;
      
      private var _disposed:Boolean;
      
      public function CollectibleProductPreviewer(param1:IBitmapWrapperController, param2:IWidgetWindowController, param3:IWidgetWindowController, param4:IStaticBitmapWrapperWindow, param5:IWidgetWindowController = null, param6:IStaticBitmapWrapperWindow = null, param7:IWidgetWindowController = null, param8:IAvatarRenderManager = null)
      {
         super();
         UnknownVarFromCollectibleProductPreviewer_IWidgetWindowController_1 = param5;
         UnknownVarFromCollectibleProductPreviewer_IWidgetWindowController_2 = param2;
         UnknownVarFromCollectibleProductPreviewer_IWidgetWindowController_3 = param3;
         UnknownVarFromCollectibleProductPreviewer_IBitmapWrapperController_1 = param1;
         UnknownVarFromCollectibleProductPreviewer_IStaticBitmapWrapperWindow_1 = param6;
         if(param7 != null && param8 != null)
         {
            UnknownVarFromCollectibleProductPreviewer_EffectPreviewer_1 = new EffectPreviewer(param7,param8);
         }
         UnknownVarFromCollectibleProductPreviewer_IStaticBitmapWrapperWindow_2 = param4;
         clearPreviewer();
      }
      
      public function clearPreviewer() : void
      {
         UnknownVarFromCollectibleProductPreviewer_Number_1 = -1;
         if(UnknownVarFromCollectibleProductPreviewer_IWidgetWindowController_1 != null)
         {
            UnknownVarFromCollectibleProductPreviewer_IWidgetWindowController_1.visible = false;
         }
         if(UnknownVarFromCollectibleProductPreviewer_IBitmapWrapperController_1 != null)
         {
            UnknownVarFromCollectibleProductPreviewer_IBitmapWrapperController_1.visible = false;
         }
         if(UnknownVarFromCollectibleProductPreviewer_IWidgetWindowController_2 != null)
         {
            UnknownVarFromCollectibleProductPreviewer_IWidgetWindowController_2.visible = false;
         }
         if(UnknownVarFromCollectibleProductPreviewer_IStaticBitmapWrapperWindow_1 != null)
         {
            UnknownVarFromCollectibleProductPreviewer_IStaticBitmapWrapperWindow_1.visible = false;
         }
         if(UnknownVarFromCollectibleProductPreviewer_IWidgetWindowController_3 != null)
         {
            UnknownVarFromCollectibleProductPreviewer_IWidgetWindowController_3.visible = false;
         }
         if(UnknownVarFromCollectibleProductPreviewer_EffectPreviewer_1 != null)
         {
            UnknownVarFromCollectibleProductPreviewer_EffectPreviewer_1.visible = false;
         }
         if(UnknownVarFromCollectibleProductPreviewer_IStaticBitmapWrapperWindow_2 != null)
         {
            UnknownVarFromCollectibleProductPreviewer_IStaticBitmapWrapperWindow_2.visible = false;
         }
      }
      
      public function set imageResult(param1:UnknownHabboRoom1) : void
      {
         clearPreviewer();
         if(!UnknownVarFromCollectibleProductPreviewer_IBitmapWrapperController_1)
         {
            return;
         }
         if(param1 != null)
         {
            UnknownVarFromCollectibleProductPreviewer_Number_1 = param1.id;
            setPreviewImage(param1.data);
         }
      }
      
      public function set avatarResult(param1:String) : void
      {
         clearPreviewer();
         if(!UnknownVarFromCollectibleProductPreviewer_IWidgetWindowController_1)
         {
            return;
         }
         UnknownVarFromCollectibleProductPreviewer_IWidgetWindowController_1.visible = true;
         var _loc2_:IAvatarImageWidget = UnknownVarFromCollectibleProductPreviewer_IWidgetWindowController_1.widget as IAvatarImageWidget;
         _loc2_.figure = param1;
      }
      
      public function set badgeResult(param1:String) : void
      {
         clearPreviewer();
         if(!UnknownVarFromCollectibleProductPreviewer_IWidgetWindowController_2)
         {
            return;
         }
         UnknownVarFromCollectibleProductPreviewer_IWidgetWindowController_2.visible = true;
         var _loc2_:IBadgeImageWidget = UnknownVarFromCollectibleProductPreviewer_IWidgetWindowController_2.widget as IBadgeImageWidget;
         _loc2_.badgeId = param1;
      }
      
      public function set petResult(param1:String) : void
      {
         clearPreviewer();
         if(!UnknownVarFromCollectibleProductPreviewer_IWidgetWindowController_3)
         {
            return;
         }
         UnknownVarFromCollectibleProductPreviewer_IWidgetWindowController_3.visible = true;
         var _loc2_:IPetImageWidget = UnknownVarFromCollectibleProductPreviewer_IWidgetWindowController_3.widget as IPetImageWidget;
         _loc2_.figure = param1;
      }
      
      public function setEffectResult(param1:String, param2:int) : void
      {
         clearPreviewer();
         if(!UnknownVarFromCollectibleProductPreviewer_EffectPreviewer_1)
         {
            return;
         }
         UnknownVarFromCollectibleProductPreviewer_EffectPreviewer_1.visible = true;
         UnknownVarFromCollectibleProductPreviewer_EffectPreviewer_1.update(param1,param2);
      }
      
      public function setUnknownImage() : void
      {
         clearPreviewer();
         if(!UnknownVarFromCollectibleProductPreviewer_IStaticBitmapWrapperWindow_2)
         {
            return;
         }
         UnknownVarFromCollectibleProductPreviewer_IStaticBitmapWrapperWindow_2.visible = true;
      }
      
      public function setPlaceholder() : void
      {
         clearPreviewer();
         if(!UnknownVarFromCollectibleProductPreviewer_IStaticBitmapWrapperWindow_1)
         {
            return;
         }
         UnknownVarFromCollectibleProductPreviewer_IStaticBitmapWrapperWindow_1.visible = true;
      }
      
      private function setPreviewImage(param1:BitmapData) : void
      {
         if(UnknownVarFromCollectibleProductPreviewer_IBitmapWrapperController_1 == null)
         {
            return;
         }
         if(param1 == null)
         {
            UnknownVarFromCollectibleProductPreviewer_IBitmapWrapperController_1.visible = false;
            return;
         }
         UnknownVarFromCollectibleProductPreviewer_IBitmapWrapperController_1.bitmap = param1.clone();
         UnknownVarFromCollectibleProductPreviewer_IBitmapWrapperController_1.visible = true;
      }
      
      public function imageReady(param1:int, param2:BitmapData) : void
      {
         if(UnknownVarFromCollectibleProductPreviewer_Number_1 == param1 && UnknownVarFromCollectibleProductPreviewer_IBitmapWrapperController_1 != null)
         {
            setPreviewImage(param2);
         }
      }
      
      public function imageFailed(param1:int) : void
      {
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         _disposed = true;
         if(UnknownVarFromCollectibleProductPreviewer_EffectPreviewer_1 != null)
         {
            UnknownVarFromCollectibleProductPreviewer_EffectPreviewer_1.dispose();
            UnknownVarFromCollectibleProductPreviewer_EffectPreviewer_1 = null;
         }
         UnknownVarFromCollectibleProductPreviewer_Number_1 = -1;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
   }
}

