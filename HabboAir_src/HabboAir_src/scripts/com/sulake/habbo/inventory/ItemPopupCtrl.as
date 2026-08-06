package com.sulake.habbo.inventory
{
   import adobe.serialization.json.JSONDecoder;
   import com.sulake.core.assets.BitmapDataAsset;
   import com.sulake.core.assets.IAssetLibraryCollection;
   import com.sulake.core.assets.loaders.AssetLoaderEvent;
   import com.sulake.core.assets.loaders.BitmapFileLoader;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.components.*;
   import com.sulake.habbo.room.IStuffData;
   import com.sulake.habbo.utils.StringUtil;
   import com.sulake.habbo.window.IHabboWindowManagerComponent;
   import com.sulake.habbo.window.widgets.ILimitedItemPreviewOverlayWidget;
   import com.sulake.habbo.window.widgets.IProductDisplayInfo;
   import com.sulake.habbo.window.widgets.IProductImageWidget;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.events.TimerEvent;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import flash.utils.Timer;
   
   public class ItemPopupCtrl
   {
      public static const UnknownConstFromItemPopupCtrl_Int_1:int = 1;
      
      public static const LOCATION_RIGHT:int = 2;
      
      private static const BOUNDS_MARGIN:int = -5;
      
      private static const OPEN_DELAY_MS:int = 250;
      
      private static const CLOSE_DELAY_MS:int = 100;
      
      private static const IMAGE_MAX_WIDTH:int = 180;
      
      private static const IMAGE_MAX_HEIGHT:int = 200;
      
      private var UnknownVarFromItemPopupCtrl_Timer_1:Timer = new Timer(250,1);
      
      private var _hideDelayTimer:Timer = new Timer(100,1);
      
      private var _assets:IAssetLibraryCollection;
      
      private var UnknownVarFromItemPopupCtrl_IWindowController_1_1:IWindowController_1;
      
      private var _parent:IWindowController_1;
      
      private var UnknownVarFromItemPopupCtrl_Int_1:int = 2;
      
      private var UnknownVarFromItemPopupCtrl_BitmapData_1:BitmapData;
      
      private var UnknownVarFromItemPopupCtrl_BitmapData_2:BitmapData;
      
      private var _inventory:HabboInventory;
      
      private var _windowManager:IHabboWindowManagerComponent;
      
      private var UnknownVarFromItemPopupCtrl_Boolean_1:Boolean = false;
      
      public function ItemPopupCtrl(param1:IWindowController_1, param2:IAssetLibraryCollection, param3:IHabboWindowManagerComponent, param4:HabboInventory)
      {
         super();
         if(param1 == null || param2 == null)
         {
            throw new Error("Null pointers passed as argument!");
         }
         UnknownVarFromItemPopupCtrl_IWindowController_1_1 = param1;
         UnknownVarFromItemPopupCtrl_IWindowController_1_1.visible = false;
         _assets = param2;
         _windowManager = param3;
         UnknownVarFromItemPopupCtrl_Timer_1.addEventListener("timer",onDisplayTimer);
         _hideDelayTimer.addEventListener("timer",onHideTimer);
         _inventory = param4;
         var _loc5_:BitmapDataAsset = _assets.getAssetByName("popup_arrow_right_png") as BitmapDataAsset;
         if(_loc5_ != null && _loc5_.content != null)
         {
            UnknownVarFromItemPopupCtrl_BitmapData_2 = _loc5_.content as BitmapData;
         }
         _loc5_ = _assets.getAssetByName("popup_arrow_left_png") as BitmapDataAsset;
         if(_loc5_ != null && _loc5_.content != null)
         {
            UnknownVarFromItemPopupCtrl_BitmapData_1 = _loc5_.content as BitmapData;
         }
      }
      
      public function dispose() : void
      {
         if(UnknownVarFromItemPopupCtrl_Timer_1 != null)
         {
            UnknownVarFromItemPopupCtrl_Timer_1.removeEventListener("timer",onDisplayTimer);
            UnknownVarFromItemPopupCtrl_Timer_1.stop();
            UnknownVarFromItemPopupCtrl_Timer_1 = null;
         }
         if(_hideDelayTimer != null)
         {
            _hideDelayTimer.removeEventListener("timer",onHideTimer);
            _hideDelayTimer.stop();
            _hideDelayTimer = null;
         }
         _assets = null;
         UnknownVarFromItemPopupCtrl_IWindowController_1_1 = null;
         _parent = null;
         UnknownVarFromItemPopupCtrl_BitmapData_1 = null;
         UnknownVarFromItemPopupCtrl_BitmapData_2 = null;
      }
      
      public function updateContent(param1:IWindowController_1, param2:String, param3:BitmapData = null, param4:IProductDisplayInfo = null, param5:IStuffData = null, param6:int = 2, param7:Boolean = false) : void
      {
         var _loc16_:String = null;
         var _loc13_:String = null;
         var _loc11_:String = null;
         var _loc12_:ILimitedItemPreviewOverlayWidget = null;
         if(UnknownVarFromItemPopupCtrl_IWindowController_1_1 == null)
         {
            return;
         }
         if(param1 == null)
         {
            return;
         }
         if(param3 == null)
         {
            param3 = new BitmapData(1,1,true,16777215);
         }
         if(_parent != null)
         {
            _parent.removeChild(UnknownVarFromItemPopupCtrl_IWindowController_1_1);
         }
         _parent = param1;
         UnknownVarFromItemPopupCtrl_Int_1 = param6;
         UnknownVarFromItemPopupCtrl_Boolean_1 = false;
         var _loc14_:ITextWindow = ITextWindow(UnknownVarFromItemPopupCtrl_IWindowController_1_1.findChildByName("item_name_text"));
         if(_loc14_)
         {
            _loc14_.text = param2;
         }
         var _loc17_:IWidgetWindowController = IWidgetWindowController(UnknownVarFromItemPopupCtrl_IWindowController_1_1.findChildByName("nft_image"));
         var _loc15_:IStaticBitmapWrapperWindow = IStaticBitmapWrapperWindow(UnknownVarFromItemPopupCtrl_IWindowController_1_1.findChildByName("nft_overlay_icon"));
         var _loc10_:IWidgetWindowController = IWidgetWindowController(UnknownVarFromItemPopupCtrl_IWindowController_1_1.findChildByName("unique_item_overlay_widget"));
         var _loc9_:IBitmapWrapperController = UnknownVarFromItemPopupCtrl_IWindowController_1_1.findChildByName("item_image") as IBitmapWrapperController;
         var _loc18_:IProductImageWidget = _loc17_.widget as IProductImageWidget;
         if(param4 != null)
         {
            _loc17_.visible = true;
            _loc15_.visible = true;
            _loc10_.visible = false;
            _loc9_.visible = false;
            _loc18_.productInfo = param4;
            UnknownVarFromItemPopupCtrl_IWindowController_1_1.height = _loc17_.bottom + 28;
            return;
         }
         _loc17_.visible = false;
         _loc18_.clearPreviewer();
         _loc15_.visible = false;
         _loc9_.visible = true;
         if(param7 && _inventory)
         {
            _loc10_.visible = false;
            _loc9_.bitmap = new BitmapData(1,1,true,16777215);
            if(param5 != null)
            {
               UnknownVarFromItemPopupCtrl_Boolean_1 = true;
               _loc16_ = param5.getJSONValue("id");
               if(!StringUtil.isBlank(_loc16_))
               {
                  loadExtraData(_loc16_);
               }
               else
               {
                  _loc13_ = param5.getJSONValue("w");
                  if(!StringUtil.isBlank(_loc13_))
                  {
                     _loc11_ = _inventory.getProperty("stories.image_url_base") + _loc13_;
                     loadImage(_loc11_);
                  }
               }
            }
            return;
         }
         var _loc8_:BitmapData = new BitmapData(Math.min(180,param3.width),Math.min(200,param3.height),true,16777215);
         _loc8_.copyPixels(param3,new Rectangle(0,0,_loc8_.width,_loc8_.height),new Point(0,0),null,null,true);
         _loc9_.bitmap = _loc8_;
         _loc9_.width = _loc9_.bitmap.width;
         _loc9_.height = _loc9_.bitmap.height;
         _loc9_.x = (UnknownVarFromItemPopupCtrl_IWindowController_1_1.width - _loc9_.width) / 2;
         UnknownVarFromItemPopupCtrl_IWindowController_1_1.height = _loc9_.bottom + 10;
         if(param5 != null && param5.uniqueSerialNumber > 0)
         {
            _loc12_ = ILimitedItemPreviewOverlayWidget(_loc10_.widget);
            _loc12_.serialNumber = param5.uniqueSerialNumber;
            _loc12_.seriesSize = param5.uniqueSeriesSize;
         }
         else
         {
            _loc10_.visible = false;
         }
      }
      
      private function loadExtraData(param1:String) : void
      {
         var _loc3_:String = _inventory.getProperty("extra_data_service_url") + param1;
         var _loc2_:URLLoader = new URLLoader(new URLRequest(_loc3_));
         _loc2_.addEventListener("complete",onExtraDataLoaded);
      }
      
      private function onExtraDataLoaded(param1:Event) : void
      {
         var _loc2_:Object = null;
         var _loc3_:String = URLLoader(param1.target).data;
         if(UnknownVarFromItemPopupCtrl_Boolean_1 && !StringUtil.isBlank(_loc3_))
         {
            try
            {
               _loc2_ = new JSONDecoder(_loc3_,false).getValue();
               loadImage(_loc2_.url);
            }
            catch(error:Error)
            {
            }
         }
      }
      
      private function loadImage(param1:String) : void
      {
         var _loc2_:BitmapFileLoader = null;
         if(!StringUtil.isBlank(param1))
         {
            _loc2_ = new BitmapFileLoader("image/png",new URLRequest(param1));
            _loc2_.addEventListener("AssetLoaderEventComplete",onExtImageLoaded);
         }
      }
      
      private function onExtImageLoaded(param1:AssetLoaderEvent) : void
      {
         if(!UnknownVarFromItemPopupCtrl_IWindowController_1_1 || !UnknownVarFromItemPopupCtrl_Boolean_1)
         {
            return;
         }
         var _loc4_:IBitmapWrapperController = UnknownVarFromItemPopupCtrl_IWindowController_1_1.findChildByName("item_image") as IBitmapWrapperController;
         if(!_loc4_ || _assets == null)
         {
            return;
         }
         var _loc6_:DisplayObject = BitmapFileLoader(param1.target).content as DisplayObject;
         var _loc2_:BitmapData = new BitmapData(Math.min(180,_loc6_.width),Math.min(200,_loc6_.height),true,16777215);
         var _loc3_:Number = 180 / _loc6_.width;
         var _loc5_:Matrix = new Matrix();
         _loc5_.scale(_loc3_,_loc3_);
         _loc2_.draw(_loc6_,_loc5_);
         _loc4_.bitmap = _loc2_;
         _loc4_.width = _loc4_.bitmap.width;
         _loc4_.height = _loc4_.bitmap.height;
         _loc4_.x = (UnknownVarFromItemPopupCtrl_IWindowController_1_1.width - _loc4_.width) / 2;
         UnknownVarFromItemPopupCtrl_IWindowController_1_1.height = _loc4_.bottom + 10;
      }
      
      public function show() : void
      {
         _hideDelayTimer.reset();
         UnknownVarFromItemPopupCtrl_Timer_1.reset();
         if(_parent == null)
         {
            return;
         }
         UnknownVarFromItemPopupCtrl_IWindowController_1_1.visible = true;
         _parent.addChild(UnknownVarFromItemPopupCtrl_IWindowController_1_1);
         refreshArrow(UnknownVarFromItemPopupCtrl_Int_1);
         switch(UnknownVarFromItemPopupCtrl_Int_1 - 1)
         {
            case 0:
               UnknownVarFromItemPopupCtrl_IWindowController_1_1.x = -1 * UnknownVarFromItemPopupCtrl_IWindowController_1_1.width - -5;
               break;
            case 1:
               UnknownVarFromItemPopupCtrl_IWindowController_1_1.x = _parent.width + -5;
         }
         UnknownVarFromItemPopupCtrl_IWindowController_1_1.y = (_parent.height - UnknownVarFromItemPopupCtrl_IWindowController_1_1.height) / 2;
      }
      
      public function hide() : void
      {
         UnknownVarFromItemPopupCtrl_IWindowController_1_1.visible = false;
         _hideDelayTimer.reset();
         UnknownVarFromItemPopupCtrl_Timer_1.reset();
         if(_parent != null)
         {
            _parent.removeChild(UnknownVarFromItemPopupCtrl_IWindowController_1_1);
         }
      }
      
      public function showDelayed() : void
      {
         _hideDelayTimer.reset();
         UnknownVarFromItemPopupCtrl_Timer_1.reset();
         UnknownVarFromItemPopupCtrl_Timer_1.start();
      }
      
      public function hideDelayed() : void
      {
         _hideDelayTimer.reset();
         UnknownVarFromItemPopupCtrl_Timer_1.reset();
         _hideDelayTimer.start();
      }
      
      private function refreshArrow(param1:int = 2) : void
      {
         if(UnknownVarFromItemPopupCtrl_IWindowController_1_1 == null || Boolean(UnknownVarFromItemPopupCtrl_IWindowController_1_1.disposed))
         {
            return;
         }
         var _loc2_:IBitmapWrapperController = IBitmapWrapperController(UnknownVarFromItemPopupCtrl_IWindowController_1_1.findChildByName("arrow_pointer"));
         if(!_loc2_)
         {
            return;
         }
         switch(param1 - 1)
         {
            case 0:
               _loc2_.bitmap = UnknownVarFromItemPopupCtrl_BitmapData_2.clone();
               _loc2_.width = UnknownVarFromItemPopupCtrl_BitmapData_2.width;
               _loc2_.height = UnknownVarFromItemPopupCtrl_BitmapData_2.height;
               _loc2_.y = (UnknownVarFromItemPopupCtrl_IWindowController_1_1.height - UnknownVarFromItemPopupCtrl_BitmapData_2.height) / 2;
               _loc2_.x = UnknownVarFromItemPopupCtrl_IWindowController_1_1.width - 1;
               break;
            case 1:
               _loc2_.bitmap = UnknownVarFromItemPopupCtrl_BitmapData_1.clone();
               _loc2_.width = UnknownVarFromItemPopupCtrl_BitmapData_1.width;
               _loc2_.height = UnknownVarFromItemPopupCtrl_BitmapData_1.height;
               _loc2_.y = (UnknownVarFromItemPopupCtrl_IWindowController_1_1.height - UnknownVarFromItemPopupCtrl_BitmapData_1.height) / 2;
               _loc2_.x = -1 * UnknownVarFromItemPopupCtrl_BitmapData_1.width + 1;
         }
         _loc2_.invalidate();
      }
      
      private function onDisplayTimer(param1:TimerEvent) : void
      {
         show();
      }
      
      private function onHideTimer(param1:TimerEvent) : void
      {
         hide();
      }
   }
}

