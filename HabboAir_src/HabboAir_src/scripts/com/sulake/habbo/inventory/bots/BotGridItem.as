package com.sulake.habbo.inventory.bots
{
   import com.sulake.core.assets.IAssetLibraryCollection;
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IBitmapWrapperController;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.communication.messages.parser.inventory.bots.BotData;
   import com.sulake.habbo.window.IHabboWindowManagerComponent;
   import flash.display.BitmapData;
   import flash.geom.Point;
   
   public class BotGridItem
   {
      private static const THUMB_COLOR_NORMAL:int = 13421772;
      
      private static const THUMB_COLOR_UNSEEN:int = 10275685;
      
      private var _data:BotData;
      
      private var _window:IWindowController_1;
      
      private var _assets:IAssetLibraryCollection;
      
      private var UnknownVarFromBotGridItem_IWindowModel_1:IWindowModel;
      
      private var UnknownVarFromBotGridItem_Boolean_1:Boolean;
      
      private var UnknownVarFromBotGridItem_BotsView_1:BotsView;
      
      private var UnknownVarFromBotGridItem_Int_1:int = -1;
      
      private var UnknownVarFromBotGridItem_Boolean_2:Boolean;
      
      private var _isUnseen:Boolean;
      
      public function BotGridItem(param1:BotsView, param2:BotData, param3:IHabboWindowManagerComponent, param4:IAssetLibraryCollection, param5:Boolean)
      {
         super();
         if(param1 == null || param2 == null || param3 == null || param4 == null)
         {
            return;
         }
         _assets = param4;
         UnknownVarFromBotGridItem_BotsView_1 = param1;
         _data = param2;
         _isUnseen = param5;
         var _loc7_:XmlAsset = param4.getAssetByName("inventory_thumb_xml") as XmlAsset;
         if(_loc7_ == null || _loc7_.content == null)
         {
            return;
         }
         _window = param3.buildFromXML(_loc7_.content as XML) as IWindowController_1;
         _window.procedure = eventHandler;
         var _loc6_:BitmapData = param1.getGridItemImage(param2);
         setImage(_loc6_);
         updateStatusGraphics();
      }
      
      public function dispose() : void
      {
         _assets = null;
         UnknownVarFromBotGridItem_BotsView_1 = null;
         _data = null;
         UnknownVarFromBotGridItem_IWindowModel_1 = null;
         UnknownVarFromBotGridItem_Int_1 = -1;
         if(_window != null)
         {
            _window.dispose();
            _window = null;
         }
      }
      
      private function eventHandler(param1:WindowEvent, param2:IWindowModel) : void
      {
         switch(param1.type)
         {
            case "WME_DOWN":
               UnknownVarFromBotGridItem_BotsView_1.setSelectedGridItem(this);
               UnknownVarFromBotGridItem_Boolean_2 = true;
               break;
            case "WME_UP":
               UnknownVarFromBotGridItem_Boolean_2 = false;
               break;
            case "WME_OUT":
               if(UnknownVarFromBotGridItem_Boolean_2)
               {
                  UnknownVarFromBotGridItem_Boolean_2 = false;
                  UnknownVarFromBotGridItem_BotsView_1.placeItemToRoom(_data.id,true);
               }
         }
      }
      
      public function setImage(param1:BitmapData) : void
      {
         if(!_window)
         {
            return;
         }
         var _loc3_:IBitmapWrapperController = _window.findChildByName("bitmap") as IBitmapWrapperController;
         var _loc2_:BitmapData = new BitmapData(_loc3_.width,_loc3_.height);
         _loc2_.fillRect(_loc2_.rect,0);
         _loc2_.copyPixels(param1,param1.rect,new Point(_loc2_.width / 2 - param1.width / 2,_loc2_.height / 2 - param1.height / 2));
         if(_loc3_.bitmap)
         {
            _loc3_.bitmap.dispose();
         }
         _loc3_.bitmap = _loc2_;
      }
      
      public function setUnseen(param1:Boolean) : void
      {
         if(_isUnseen != param1)
         {
            _isUnseen = param1;
            updateStatusGraphics();
         }
      }
      
      public function setSelected(param1:Boolean) : void
      {
         if(UnknownVarFromBotGridItem_Boolean_1 != param1)
         {
            UnknownVarFromBotGridItem_Boolean_1 = param1;
            if(!_window || !UnknownVarFromBotGridItem_IWindowModel_1)
            {
               return;
            }
            updateStatusGraphics();
         }
      }
      
      private function updateStatusGraphics() : void
      {
         var _loc1_:IWindowModel = _window.findChildByName("outline");
         if(_loc1_ != null)
         {
            _loc1_.visible = UnknownVarFromBotGridItem_Boolean_1;
         }
         if(!UnknownVarFromBotGridItem_IWindowModel_1)
         {
            UnknownVarFromBotGridItem_IWindowModel_1 = _window.findChildByTag("BG_COLOR");
         }
         UnknownVarFromBotGridItem_IWindowModel_1.color = _isUnseen ? 10275685 : 13421772;
      }
      
      public function get window() : IWindowModel
      {
         return _window;
      }
      
      public function get data() : BotData
      {
         return _data;
      }
   }
}

