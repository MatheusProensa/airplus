package com.sulake.habbo.ui.widget.furniture.backgroundcolor
{
   import com.sulake.core.assets.IAssetLibraryCollection;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IBitmapWrapperController;
   import com.sulake.core.window.components.IFrameController;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.communication.messages.outgoing.room.engine.UseFurnitureMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.room.furniture.SetRoomBackgroundColorDataComposer;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   import com.sulake.habbo.ui.IRoomWidgetHandler;
   import com.sulake.habbo.ui.handler.FurnitureBackgroundColorWidgetHandler;
   import com.sulake.habbo.ui.widget.RoomWidgetBase;
   import com.sulake.habbo.window.IHabboWindowManagerComponent;
   import com.sulake.room.utils.ColorConverter;
   import flash.display.BitmapData;
   
   public class BackgroundColorFurniWidget extends RoomWidgetBase
   {
      private static const PARAMETER_HUE:String = "hue";
      
      private static const PARAMETER_SATURATION:String = "saturation";
      
      private static const PARAMETER_LIGHTNESS:String = "lightness";
      
      private var _window:IFrameController;
      
      private var UnknownVarFromBackgroundColorFurniWidget_Int_1:int;
      
      private var _sliders:Vector.<BackgroundColorWidgetSlider> = new Vector.<BackgroundColorWidgetSlider>();
      
      private var UnknownVarFromBackgroundColorFurniWidget_Int_2:int;
      
      private var UnknownVarFromBackgroundColorFurniWidget_Int_3:int;
      
      private var UnknownVarFromBackgroundColorFurniWidget_Int_4:int;
      
      public function BackgroundColorFurniWidget(param1:IRoomWidgetHandler, param2:IHabboWindowManagerComponent, param3:IAssetLibraryCollection = null, param4:IHabboLocalizationManager = null)
      {
         super(param1,param2,param3,param4);
         this.handler.widget = this;
      }
      
      public function get handler() : FurnitureBackgroundColorWidgetHandler
      {
         return _widgetHandler as FurnitureBackgroundColorWidgetHandler;
      }
      
      override public function dispose() : void
      {
         destroyWindow();
         super.dispose();
      }
      
      public function open(param1:int, param2:int, param3:int, param4:int) : void
      {
         UnknownVarFromBackgroundColorFurniWidget_Int_1 = param1;
         UnknownVarFromBackgroundColorFurniWidget_Int_2 = Math.max(param2,0);
         UnknownVarFromBackgroundColorFurniWidget_Int_3 = Math.max(param3,0);
         UnknownVarFromBackgroundColorFurniWidget_Int_4 = Math.max(param4,0);
         createWindow();
      }
      
      public function setParameterCallback(param1:String, param2:int) : void
      {
         switch(param1)
         {
            case "hue":
               UnknownVarFromBackgroundColorFurniWidget_Int_2 = param2;
               break;
            case "saturation":
               UnknownVarFromBackgroundColorFurniWidget_Int_3 = param2;
               break;
            case "lightness":
               UnknownVarFromBackgroundColorFurniWidget_Int_4 = param2;
         }
         renderColorPreview();
      }
      
      private function createWindow() : void
      {
         if(!_window)
         {
            _window = IFrameController(windowManager.buildFromXML(assets.getAssetByName("background_color_ui_xml").content as XML));
            _window.procedure = windowProcedure;
            _window.center();
            _sliders.push(new BackgroundColorWidgetSlider(this,"hue",IWindowController_1(_window.findChildByName("hue_container")),UnknownVarFromBackgroundColorFurniWidget_Int_2));
            _sliders.push(new BackgroundColorWidgetSlider(this,"saturation",IWindowController_1(_window.findChildByName("saturation_container")),UnknownVarFromBackgroundColorFurniWidget_Int_3));
            _sliders.push(new BackgroundColorWidgetSlider(this,"lightness",IWindowController_1(_window.findChildByName("lightness_container")),UnknownVarFromBackgroundColorFurniWidget_Int_4));
         }
      }
      
      private function destroyWindow() : void
      {
         for each(var _loc1_ in _sliders)
         {
            _loc1_.dispose();
         }
         _sliders = new Vector.<BackgroundColorWidgetSlider>();
         if(_window)
         {
            _window.dispose();
            _window = null;
         }
      }
      
      private function renderColorPreview() : void
      {
         if(_window == null)
         {
            return;
         }
         var _loc3_:IBitmapWrapperController = IBitmapWrapperController(_window.findChildByName("color_preview_bitmap"));
         var _loc2_:BitmapData = new BitmapData(_loc3_.width,_loc3_.height,false);
         var _loc1_:uint = ColorConverter.hslToRGB(((UnknownVarFromBackgroundColorFurniWidget_Int_2 & 0xFF) << 16) + ((UnknownVarFromBackgroundColorFurniWidget_Int_3 & 0xFF) << 8) + (UnknownVarFromBackgroundColorFurniWidget_Int_4 & 0xFF));
         _loc2_.fillRect(_loc2_.rect,_loc1_);
         _loc3_.bitmap = _loc2_;
      }
      
      private function windowProcedure(param1:WindowEvent, param2:IWindowModel) : void
      {
         if(param2 != null && param1.type == "WME_CLICK")
         {
            switch(param2.name)
            {
               case "apply_button":
                  handler.container.connection.send(new SetRoomBackgroundColorDataComposer(UnknownVarFromBackgroundColorFurniWidget_Int_1,UnknownVarFromBackgroundColorFurniWidget_Int_2,UnknownVarFromBackgroundColorFurniWidget_Int_3,UnknownVarFromBackgroundColorFurniWidget_Int_4));
                  break;
               case "on_off_button":
                  handler.container.connection.send(new UseFurnitureMessageComposer(UnknownVarFromBackgroundColorFurniWidget_Int_1));
                  break;
               case "header_button_close":
                  destroyWindow();
            }
         }
      }
   }
}

