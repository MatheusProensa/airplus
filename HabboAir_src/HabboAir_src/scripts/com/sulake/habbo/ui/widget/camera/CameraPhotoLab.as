package com.sulake.habbo.ui.widget.camera
{
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.core.utils.Map;
   import com.sulake.core.utils.images.PNGEncoder;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IBitmapWrapperController;
   import com.sulake.core.window.components.IDisplayObjectWrapperController;
   import com.sulake.core.window.components.IFrameController;
   import com.sulake.core.window.components.IRegionWindow;
   import com.sulake.core.window.components.IScrollableGridWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.UnknownICoreWindowComponents6;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.events.WindowKeyboardEvent;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.communication.messages.incoming.camera.CameraPublishStatusMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.camera.CompetitionStatusMessageEvent;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   import com.sulake.habbo.quest.IHabboQuestEngine;
   import com.sulake.habbo.tracking.HabboTracking;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.ColorTransform;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.globalization.DateTimeFormatter;
   import flash.net.FileReference;
   import flash.utils.ByteArray;
   import flash.utils.setTimeout;
   
   public class CameraPhotoLab implements IComponentInterfaceQueue
   {
      private static var TEXT_WIDTH_MARGIN:int = 6;
      
      private static var UnknownVarFromCameraPhotoLab_PhotoPurchaseConfirmationDialog_1:PhotoPurchaseConfirmationDialog;
      
      private var UnknownVarFromCameraPhotoLab_CameraWidget_1:CameraWidget;
      
      private var _window:IWindowController_1;
      
      private var _disposed:Boolean = false;
      
      private var UnknownVarFromCameraPhotoLab_IBitmapWrapperController_1:IBitmapWrapperController;
      
      private var UnknownVarFromCameraPhotoLab_BitmapData_1:BitmapData;
      
      private var UnknownVarFromCameraPhotoLab_CameraFxStrengthSlider_1:CameraFxStrengthSlider;
      
      private var _sliderEffectInfo:ITextWindow;
      
      private var UnknownVarFromCameraPhotoLab_CameraEffect_1:CameraEffect;
      
      private var UnknownVarFromCameraPhotoLab_Map_1:Map = new Map();
      
      private var _itemGrid:IScrollableGridWindow;
      
      private var UnknownVarFromCameraPhotoLab_Sprite_1:Sprite;
      
      private var UnknownVarFromCameraPhotoLab_Map_2:Map = new Map();
      
      private var _captionInputKeyEvents:int = 0;
      
      private var UnknownVarFromCameraPhotoLab_String_1:String = "";
      
      private var UnknownVarFromCameraPhotoLab_Boolean_1:Boolean = false;
      
      private var UnknownVarFromCameraPhotoLab_FileReference_1:FileReference = new FileReference();
      
      public function CameraPhotoLab(param1:CameraWidget)
      {
         super();
         UnknownVarFromCameraPhotoLab_CameraWidget_1 = param1;
      }
      
      public static function preloadEffects(param1:String, param2:String, param3:IHabboLocalizationManager) : void
      {
         var _loc5_:Array = [];
         var _loc4_:Map = CameraEffect.getEffects(param2,param3);
         for each(var _loc6_ in _loc4_)
         {
            if(_loc6_.type == "composite" || _loc6_.type == "frame")
            {
               _loc5_.push(_loc6_.name);
            }
         }
         CameraFxPreloader.init(param1,_loc5_);
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         if(UnknownVarFromCameraPhotoLab_PhotoPurchaseConfirmationDialog_1)
         {
            UnknownVarFromCameraPhotoLab_PhotoPurchaseConfirmationDialog_1.hide();
         }
         CameraEffect.resetAllEffects();
         UnknownVarFromCameraPhotoLab_BitmapData_1 = null;
         UnknownVarFromCameraPhotoLab_CameraWidget_1 = null;
         UnknownVarFromCameraPhotoLab_IBitmapWrapperController_1 = null;
         if(UnknownVarFromCameraPhotoLab_CameraFxStrengthSlider_1 != null)
         {
            UnknownVarFromCameraPhotoLab_CameraFxStrengthSlider_1.dispose();
            UnknownVarFromCameraPhotoLab_CameraFxStrengthSlider_1 = null;
         }
         _sliderEffectInfo = null;
         UnknownVarFromCameraPhotoLab_CameraEffect_1 = null;
         UnknownVarFromCameraPhotoLab_Map_1 = null;
         UnknownVarFromCameraPhotoLab_Map_2 = null;
         _disposed = true;
         if(_window)
         {
            _window.dispose();
         }
         _window = null;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      private function setImageAndFilterButtons(param1:BitmapData) : void
      {
         UnknownVarFromCameraPhotoLab_BitmapData_1 = param1.clone();
         UnknownVarFromCameraPhotoLab_IBitmapWrapperController_1.bitmap = param1;
         buildFilterButtons();
      }
      
      internal function setSelectedFxValue(param1:Number) : void
      {
         if(UnknownVarFromCameraPhotoLab_CameraEffect_1)
         {
            UnknownVarFromCameraPhotoLab_CameraEffect_1.value = param1;
            updateSliderEffectInfo();
            renderAllEffects();
         }
      }
      
      private function updateSliderEffectInfo() : void
      {
         _sliderEffectInfo.text = UnknownVarFromCameraPhotoLab_CameraEffect_1.description + " " + int(UnknownVarFromCameraPhotoLab_CameraEffect_1.getEffectStrength() * 100) + "%";
         _sliderEffectInfo.width = _sliderEffectInfo.textWidth + TEXT_WIDTH_MARGIN;
      }
      
      internal function setCaptionText(param1:String) : void
      {
         ITextWindow(_window.findChildByName("captionInput")).text = param1;
      }
      
      private function buildTypeButtons() : void
      {
         var _loc5_:int = 0;
         _loc5_ = 6;
         var _loc3_:int = 0;
         _loc3_ = 2;
         if(UnknownVarFromCameraPhotoLab_Map_2.length > 0)
         {
            return;
         }
         var _loc1_:int = (_window as IFrameController).margins.left + _itemGrid.x;
         var _loc2_:IWindowController_1 = createTypeButton("colormatrix","camera_icon_colorfilter");
         _loc2_.x = _loc1_ + (_itemGrid.width - (2 * (_loc2_.width + 6) - 6)) / 2;
         _loc2_.y = 50;
         _window.addChild(_loc2_);
         var _loc4_:IWindowController_1 = createTypeButton("composite","camera_icon_compositefilter");
         _loc4_.x = _loc2_.right + 6;
         _loc4_.y = _loc2_.y;
         _window.addChild(_loc4_);
      }
      
      private function buildFilterButtons() : void
      {
         var _loc1_:IWindowController_1 = null;
         var _loc5_:String = null;
         if(CameraFxPreloader.preloadFinished() == false)
         {
            setTimeout(buildFilterButtons,200);
         }
         var _loc6_:int = 0;
         var _loc7_:IHabboQuestEngine = UnknownVarFromCameraPhotoLab_CameraWidget_1.handler.roomDesktop.questEngine;
         if(_loc7_ != null)
         {
            _loc6_ = _loc7_.getAchievementLevel("explore","ACH_CameraPhotoCount");
            if(_loc6_ == 0)
            {
               _loc6_ = _loc7_.getAchievementLevel("archive","ACH_CameraPhotoCount");
            }
         }
         var _loc2_:Map = CameraEffect.getEffects(UnknownVarFromCameraPhotoLab_CameraWidget_1.component.getProperty("camera.available.effects"),UnknownVarFromCameraPhotoLab_CameraWidget_1.localizations);
         for each(var _loc4_ in _loc2_)
         {
            _loc1_ = createFxButton(_loc4_,UnknownVarFromCameraPhotoLab_BitmapData_1.clone(),_loc6_);
            if(_loc1_)
            {
               _loc5_ = _loc4_.description;
               if(_loc6_ < _loc4_.achievementLevel)
               {
                  _loc5_ = UnknownVarFromCameraPhotoLab_CameraWidget_1.localizations.getLocalization("camera.effect.required.level") + " " + _loc4_.achievementLevel;
               }
               IRegionWindow(_loc1_).toolTipCaption = _loc5_;
            }
         }
         var _loc3_:IWindowController_1 = _window.findChildByName("slider_container") as IWindowController_1;
         UnknownVarFromCameraPhotoLab_CameraFxStrengthSlider_1 = new CameraFxStrengthSlider(this,_loc3_,UnknownVarFromCameraPhotoLab_CameraWidget_1.windowManager.assets);
         UnknownVarFromCameraPhotoLab_CameraFxStrengthSlider_1.disable();
         CameraEffect.setMaxValue(UnknownVarFromCameraPhotoLab_CameraFxStrengthSlider_1.getScale());
         setFilterType("colormatrix");
      }
      
      private function createTypeButton(param1:String, param2:String) : IWindowController_1
      {
         var _loc3_:IRegionWindow = UnknownVarFromCameraPhotoLab_CameraWidget_1.getXmlWindow("camera_typebutton") as IRegionWindow;
         var _loc4_:IBitmapWrapperController = _loc3_.findChildByName("icon") as IBitmapWrapperController;
         _loc4_.bitmap = (UnknownVarFromCameraPhotoLab_CameraWidget_1.windowManager.assets.getAssetByName(param2).content as BitmapData).clone();
         _loc3_.name = "typebutton," + param1;
         _loc3_.toolTipCaption = param1;
         UnknownVarFromCameraPhotoLab_Map_2.add(param1,_loc3_);
         return _loc3_;
      }
      
      private function createFxButton(param1:CameraEffect, param2:BitmapData, param3:int) : IWindowController_1
      {
         var _loc7_:IBitmapWrapperController = null;
         var _loc5_:Number = NaN;
         var _loc8_:Matrix = null;
         var _loc9_:Bitmap = null;
         var _loc6_:IWindowModel = null;
         var _loc4_:IWindowController_1 = UnknownVarFromCameraPhotoLab_CameraWidget_1.getXmlWindow("camera_filterbutton") as IWindowController_1;
         if(param3 >= param1.achievementLevel)
         {
            _loc7_ = _loc4_.findChildByName("content") as IBitmapWrapperController;
            _loc7_.bitmap = new BitmapData(_loc7_.width,_loc7_.height,true,0);
            _loc5_ = _loc7_.width / param2.width;
            _loc8_ = new Matrix();
            _loc8_.scale(_loc5_,_loc5_);
            _loc9_ = new Bitmap(param2,"auto",true);
            switch(param1.type)
            {
               case "colormatrix":
                  param2.applyFilter(param2,param2.rect,new Point(0,0),param1.getColorMatrixFilter(true));
                  break;
               case "composite":
                  if(CameraFxPreloader.getImage(param1.name) == null)
                  {
                     return null;
                  }
                  param2.draw(CameraFxPreloader.getImage(param1.name),null,null,param1.blendmode,null,true);
                  break;
               case "frame":
                  if(CameraFxPreloader.getImage(param1.name) == null)
                  {
                     return null;
                  }
                  param2.draw(CameraFxPreloader.getImage(param1.name),null,null,null,null,true);
                  break;
            }
            _loc7_.bitmap.draw(_loc9_,_loc8_,null,null,null,true);
            _loc4_.procedure = effectButtonClick;
         }
         else
         {
            _loc6_ = _loc4_.findChildByName("lock_indicator") as IWindowModel;
            _loc6_.visible = true;
         }
         _loc4_.name = param1.name;
         param1.button = _loc4_;
         UnknownVarFromCameraPhotoLab_Map_1[_loc4_.name] = param1;
         return _loc4_;
      }
      
      public function openPhotoLab(param1:BitmapData) : void
      {
         _window = UnknownVarFromCameraPhotoLab_CameraWidget_1.getXmlWindow("camera_editor") as IWindowController_1;
         _window.center();
         if(UnknownVarFromCameraPhotoLab_CameraWidget_1.component.getProperty("camera.effects.enabled") != "true")
         {
            openPurchaseConfirmationDialog(null);
            return;
         }
         _itemGrid = _window.findChildByName("item_grid") as IScrollableGridWindow;
         _itemGrid.spacing = 7;
         UnknownVarFromCameraPhotoLab_IBitmapWrapperController_1 = _window.findChildByName("image") as IBitmapWrapperController;
         _window.procedure = windowEventHandler;
         var _loc10_:ITextWindow = ITextWindow(_window.findChildByName("captionInput"));
         _loc10_.procedure = captionProcedure;
         var _loc6_:IDisplayObjectWrapperController = _window.findChildByName("purchase_display_object") as IDisplayObjectWrapperController;
         UnknownVarFromCameraPhotoLab_Sprite_1 = new Sprite();
         UnknownVarFromCameraPhotoLab_Sprite_1.graphics.beginFill(16711680,0);
         UnknownVarFromCameraPhotoLab_Sprite_1.graphics.drawRect(0,0,_loc6_.width,_loc6_.height);
         _loc6_.setDisplayObject(UnknownVarFromCameraPhotoLab_Sprite_1);
         UnknownVarFromCameraPhotoLab_Sprite_1.addEventListener("click",openPurchaseConfirmationDialog);
         var _loc7_:IRegionWindow = _window.findChildByName("zoom_button") as IRegionWindow;
         var _loc11_:UnknownICoreWindowComponents6 = _loc7_.getChildByName("centerizer") as UnknownICoreWindowComponents6;
         var _loc5_:ITextWindow = _loc11_.getChildByName("zoom_text") as ITextWindow;
         _loc5_.width = _loc5_.textWidth + TEXT_WIDTH_MARGIN;
         var _loc8_:IRegionWindow = _window.findChildByName("save_button") as IRegionWindow;
         var _loc4_:UnknownICoreWindowComponents6 = _loc8_.getChildByName("centerizer") as UnknownICoreWindowComponents6;
         var _loc9_:ITextWindow = _loc4_.getChildByName("save_text") as ITextWindow;
         _loc9_.width = _loc9_.textWidth + TEXT_WIDTH_MARGIN;
         var _loc2_:IDisplayObjectWrapperController = _window.findChildByName("save_click_catcher") as IDisplayObjectWrapperController;
         var _loc3_:Sprite = new Sprite();
         _loc3_.graphics.beginFill(16711680,0);
         _loc3_.graphics.drawRect(0,0,_loc2_.width,_loc2_.height);
         _loc2_.setDisplayObject(_loc3_);
         _loc3_.addEventListener("click",offerSaveAsFile);
         buildTypeButtons();
         setImageAndFilterButtons(param1);
         _sliderEffectInfo = _window.findChildByName("slider_effect_info") as ITextWindow;
         CameraEffect.resetAllEffects();
      }
      
      private function effectButtonClick(param1:WindowEvent, param2:IWindowModel) : void
      {
         var _loc3_:CameraEffect = null;
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         if(param2.name == "remove_effect_button")
         {
            if(UnknownVarFromCameraPhotoLab_Map_1.hasKey(param2.parent.name))
            {
               _loc3_ = UnknownVarFromCameraPhotoLab_Map_1[param2.parent.name];
               _loc3_.setChosen(false);
               if(UnknownVarFromCameraPhotoLab_CameraEffect_1 == _loc3_)
               {
                  UnknownVarFromCameraPhotoLab_CameraFxStrengthSlider_1.disable();
                  UnknownVarFromCameraPhotoLab_CameraEffect_1 = null;
               }
               renderAllEffects();
               return;
            }
         }
         if(UnknownVarFromCameraPhotoLab_Map_1.hasKey(param2.name))
         {
            setActiveEffect(UnknownVarFromCameraPhotoLab_Map_1[param2.name]);
         }
      }
      
      private function captionProcedure(param1:WindowEvent, param2:IWindowModel) : void
      {
         if(param1.type == "WKE_KEY_DOWN")
         {
            if(WindowKeyboardEvent(param1).ctrlKey || WindowKeyboardEvent(param1).charCode == 0)
            {
               _captionInputKeyEvents = 0;
            }
            else
            {
               _captionInputKeyEvents++;
            }
         }
         else if(param1.type == "WKE_KEY_UP")
         {
            _captionInputKeyEvents = 0;
         }
         else if(param1.type == "WE_CHANGE")
         {
            if(_captionInputKeyEvents == 1)
            {
               UnknownVarFromCameraPhotoLab_String_1 = ITextWindow(_window.findChildByName("captionInput")).text;
            }
            else
            {
               setCaptionText(UnknownVarFromCameraPhotoLab_String_1);
            }
            _captionInputKeyEvents = 0;
         }
      }
      
      private function openPurchaseConfirmationDialog(param1:MouseEvent) : void
      {
         if(UnknownVarFromCameraPhotoLab_PhotoPurchaseConfirmationDialog_1)
         {
            UnknownVarFromCameraPhotoLab_PhotoPurchaseConfirmationDialog_1.hide();
         }
         if(UnknownVarFromCameraPhotoLab_CameraWidget_1.container.sessionDataManager.isAccountSafetyLocked())
         {
            UnknownVarFromCameraPhotoLab_CameraWidget_1.windowManager.alert("${generic.alert.title}","${notifications.text.safety_locked}",0,null);
            if(UnknownVarFromCameraPhotoLab_CameraWidget_1.component.getProperty("camera.effects.enabled") != "true")
            {
               dispose();
            }
            return;
         }
         UnknownVarFromCameraPhotoLab_PhotoPurchaseConfirmationDialog_1 = new PhotoPurchaseConfirmationDialog(UnknownVarFromCameraPhotoLab_CameraWidget_1,ITextWindow(_window.findChildByName("captionInput")).text);
         var _loc2_:Boolean = UnknownVarFromCameraPhotoLab_CameraWidget_1.sendPhotoData();
         UnknownVarFromCameraPhotoLab_PhotoPurchaseConfirmationDialog_1.setPrices(UnknownVarFromCameraPhotoLab_CameraWidget_1.handler.creditPrice,UnknownVarFromCameraPhotoLab_CameraWidget_1.handler.ducketPrice,UnknownVarFromCameraPhotoLab_CameraWidget_1.handler.publishDucketPrice);
         HabboTracking.getInstance().trackEventLog("Stories","camera","stories.photo.purchase_dialog_opened");
         if(!_loc2_)
         {
            UnknownVarFromCameraPhotoLab_PhotoPurchaseConfirmationDialog_1.setRenderingFailed();
            UnknownVarFromCameraPhotoLab_CameraWidget_1.windowManager.alert("${generic.alert.title}","${camera.alert.too_much_stuff}",0,null);
         }
         hide();
      }
      
      public function hide() : void
      {
         _window.visible = false;
      }
      
      public function show() : void
      {
         _window.visible = true;
      }
      
      public function closePurchaseConfirmation() : void
      {
         if(UnknownVarFromCameraPhotoLab_PhotoPurchaseConfirmationDialog_1)
         {
            UnknownVarFromCameraPhotoLab_PhotoPurchaseConfirmationDialog_1.hide();
            UnknownVarFromCameraPhotoLab_PhotoPurchaseConfirmationDialog_1 = null;
         }
      }
      
      internal function animateSuccessfulPurchase() : void
      {
         if(UnknownVarFromCameraPhotoLab_PhotoPurchaseConfirmationDialog_1)
         {
            UnknownVarFromCameraPhotoLab_PhotoPurchaseConfirmationDialog_1.animateIconToToolbar();
         }
      }
      
      public function publishingStatus(param1:CameraPublishStatusMessageEvent) : void
      {
         if(UnknownVarFromCameraPhotoLab_PhotoPurchaseConfirmationDialog_1)
         {
            UnknownVarFromCameraPhotoLab_PhotoPurchaseConfirmationDialog_1.publishingStatus(param1);
         }
      }
      
      public function competitionStatus(param1:CompetitionStatusMessageEvent) : void
      {
         if(UnknownVarFromCameraPhotoLab_PhotoPurchaseConfirmationDialog_1)
         {
            UnknownVarFromCameraPhotoLab_PhotoPurchaseConfirmationDialog_1.competitionStatus(param1);
         }
      }
      
      private function offerSaveAsFile(param1:MouseEvent) : void
      {
         var _loc2_:DateTimeFormatter = null;
         var _loc4_:String = null;
         var _loc3_:BitmapData = UnknownVarFromCameraPhotoLab_IBitmapWrapperController_1.bitmap.clone();
         var _loc5_:ByteArray = PNGEncoder.encode(_loc3_);
         try
         {
            _loc2_ = new DateTimeFormatter("i-default");
            _loc2_.setDateTimePattern("yyyy-MM-dd_HH-mm-ss");
            _loc4_ = "Habbo_" + _loc2_.format(new Date()) + ".png";
            UnknownVarFromCameraPhotoLab_FileReference_1.save(_loc5_,_loc4_);
         }
         catch(error:Error)
         {
         }
      }
      
      public function logChosenEffects() : void
      {
         for each(var _loc1_ in UnknownVarFromCameraPhotoLab_Map_1)
         {
            if(_loc1_.isOn)
            {
               HabboTracking.getInstance().trackEventLog("Stories","camera","stories.photo.effect.chosen",_loc1_.name);
            }
         }
      }
      
      private function windowEventHandler(param1:WindowEvent, param2:IWindowModel) : void
      {
         if(_disposed || !_window || param1.type != "WME_CLICK")
         {
            return;
         }
         switch(param2.name)
         {
            case "cancel_button":
               UnknownVarFromCameraPhotoLab_CameraWidget_1.startTakingPhoto("effectEditorCancel");
               dispose();
               break;
            case "header_button_close":
               dispose();
               break;
            case "help_button":
               UnknownVarFromCameraPhotoLab_CameraWidget_1.component.context.createLinkEvent("habbopages/camera");
               break;
            case "save_button":
            case "slider_container":
               break;
            case "zoom_button":
               UnknownVarFromCameraPhotoLab_Boolean_1 = !UnknownVarFromCameraPhotoLab_Boolean_1;
               renderAllEffects();
               break;
            default:
               UnknownVarFromCameraPhotoLab_CameraFxStrengthSlider_1.disable();
               if(UnknownVarFromCameraPhotoLab_CameraEffect_1 != null)
               {
                  UnknownVarFromCameraPhotoLab_CameraEffect_1.turnOffHighlight();
               }
         }
         if(param2.name.indexOf("typebutton") != -1)
         {
            setFilterType(param2.name.split(",")[1]);
         }
      }
      
      private function setActiveEffect(param1:CameraEffect) : void
      {
         if(UnknownVarFromCameraPhotoLab_CameraEffect_1 != null)
         {
            UnknownVarFromCameraPhotoLab_CameraEffect_1.turnOffHighlight();
         }
         UnknownVarFromCameraPhotoLab_CameraEffect_1 = param1;
         UnknownVarFromCameraPhotoLab_CameraEffect_1.setChosen(true);
         if(param1.usesEffectStrength())
         {
            UnknownVarFromCameraPhotoLab_CameraFxStrengthSlider_1.enable();
            UnknownVarFromCameraPhotoLab_CameraFxStrengthSlider_1.setValue(param1.value);
            updateSliderEffectInfo();
         }
         else
         {
            UnknownVarFromCameraPhotoLab_CameraFxStrengthSlider_1.disable();
         }
         if(param1.allowsOnlyOneInstance())
         {
            turnOffOtherEffectsOfSameType(param1);
         }
         renderAllEffects();
      }
      
      private function turnOffOtherEffectsOfSameType(param1:CameraEffect) : void
      {
         for each(var _loc2_ in UnknownVarFromCameraPhotoLab_Map_1)
         {
            if(_loc2_.type == param1.type && _loc2_ != param1)
            {
               _loc2_.setChosen(false);
            }
         }
      }
      
      private function setFilterType(param1:String) : void
      {
         if(UnknownVarFromCameraPhotoLab_CameraEffect_1 != null)
         {
            UnknownVarFromCameraPhotoLab_CameraEffect_1.turnOffHighlight();
         }
         _itemGrid.removeGridItems();
         for each(var _loc2_ in UnknownVarFromCameraPhotoLab_Map_1)
         {
            if(_loc2_.type == param1)
            {
               _itemGrid.addGridItem(_loc2_.button);
            }
         }
         highlightSelectedButtonType(param1);
      }
      
      private function highlightSelectedButtonType(param1:String) : void
      {
         var _loc3_:IWindowModel = null;
         for each(var _loc2_ in UnknownVarFromCameraPhotoLab_Map_2)
         {
            _loc3_ = _loc2_.findChildByName("active_border");
            _loc3_.visible = _loc2_.name == "typebutton," + param1;
         }
      }
      
      private function renderAllEffects() : void
      {
         var _loc2_:ColorTransform = null;
         var _loc5_:Matrix = null;
         var _loc3_:BitmapData = null;
         var _loc1_:* = UnknownVarFromCameraPhotoLab_BitmapData_1.clone();
         if(UnknownVarFromCameraPhotoLab_Boolean_1)
         {
            _loc5_ = new Matrix();
            _loc5_.a = 2;
            _loc5_.d = 2;
            _loc5_.tx = -_loc1_.width / 2;
            _loc5_.ty = -_loc1_.height / 2;
            _loc3_ = new BitmapData(_loc1_.width,_loc1_.height);
            _loc3_.draw(_loc1_,_loc5_);
            _loc1_ = _loc3_;
         }
         for each(var _loc4_ in UnknownVarFromCameraPhotoLab_Map_1)
         {
            if(_loc4_.isOn)
            {
               if(_loc4_.type == "colormatrix")
               {
                  _loc1_.applyFilter(_loc1_,_loc1_.rect,new Point(0,0),_loc4_.getColorMatrixFilter());
               }
               if(_loc4_.type == "composite")
               {
                  _loc2_ = new ColorTransform(1,1,1,_loc4_.getEffectStrength());
                  _loc1_.draw(CameraFxPreloader.getImage(_loc4_.name),null,_loc2_,_loc4_.blendmode);
               }
            }
         }
         for each(var _loc6_ in UnknownVarFromCameraPhotoLab_Map_1)
         {
            if(_loc6_.isOn && _loc6_.type == "frame")
            {
               _loc1_.draw(CameraFxPreloader.getImage(_loc6_.name));
            }
         }
         UnknownVarFromCameraPhotoLab_IBitmapWrapperController_1.bitmap = _loc1_;
         UnknownVarFromCameraPhotoLab_IBitmapWrapperController_1.invalidate();
      }
      
      protected function onClose(param1:WindowMouseEvent) : void
      {
         dispose();
      }
      
      public function setRenderedPhotoUrl(param1:String) : void
      {
         if(UnknownVarFromCameraPhotoLab_PhotoPurchaseConfirmationDialog_1)
         {
            UnknownVarFromCameraPhotoLab_PhotoPurchaseConfirmationDialog_1.setImageUrl(param1);
         }
      }
      
      public function getEffectDataJson() : String
      {
         var _loc2_:Object = null;
         var _loc1_:Vector.<Object> = new Vector.<Object>();
         for each(var _loc3_ in UnknownVarFromCameraPhotoLab_Map_1)
         {
            if(_loc3_.isOn && _loc3_.type != "frame")
            {
               _loc2_ = {};
               _loc2_.name = _loc3_.name;
               _loc2_.alpha = int(_loc3_.getEffectStrength() * 255);
               _loc1_.push(_loc2_);
            }
         }
         for each(var _loc4_ in UnknownVarFromCameraPhotoLab_Map_1)
         {
            if(_loc4_.isOn && _loc4_.type == "frame")
            {
               _loc2_ = {};
               _loc2_.name = _loc4_.name;
               _loc1_.push(_loc2_);
            }
         }
         return JSON.stringify(_loc1_);
      }
      
      public function getZoom() : int
      {
         return UnknownVarFromCameraPhotoLab_Boolean_1 ? 2 : 1;
      }
   }
}

