package com.sulake.habbo.ui.widget.furniture.trophy
{
   import com.sulake.core.assets.BitmapDataAsset;
   import com.sulake.core.assets.ISoundAsset;
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IBitmapWrapperController;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.events.WindowMouseEvent;
   import flash.display.BitmapData;
   
   public class TrophyView implements ITrophyView
   {
      private var UnknownVarFromTrophyView_ITrophyFurniWidget_1:ITrophyFurniWidget;
      
      private var _window:IWindowController_1;
      
      public function TrophyView(param1:ITrophyFurniWidget)
      {
         super();
         UnknownVarFromTrophyView_ITrophyFurniWidget_1 = param1;
      }
      
      public function dispose() : void
      {
         if(_window)
         {
            _window.dispose();
            _window = null;
         }
         UnknownVarFromTrophyView_ITrophyFurniWidget_1 = null;
      }
      
      public function showInterface() : Boolean
      {
         var _loc2_:IWindowModel = null;
         var _loc9_:IWindowController_1 = null;
         var _loc11_:ITextWindow = null;
         var _loc6_:ITextWindow = null;
         var _loc3_:ITextWindow = null;
         var _loc7_:ITextWindow = null;
         var _loc5_:BitmapDataAsset = null;
         var _loc4_:BitmapData = null;
         var _loc8_:IBitmapWrapperController = null;
         var _loc10_:ISoundAsset = UnknownVarFromTrophyView_ITrophyFurniWidget_1.assets.getAssetByName("trophy");
         var _loc1_:XmlAsset = XmlAsset(_loc10_);
         if(_loc1_ == null)
         {
            return false;
         }
         if(_window == null)
         {
            _window = UnknownVarFromTrophyView_ITrophyFurniWidget_1.windowManager.buildFromXML(_loc1_.content as XML) as IWindowController_1;
         }
         _window.center();
         _loc2_ = _window.findChildByName("close");
         if(_loc2_ != null)
         {
            _loc2_.addEventListener("WME_CLICK",onMouseEvent);
         }
         _loc9_ = _window.findChildByName("title_bg") as IWindowController_1;
         if(_loc9_ != null)
         {
            _loc9_.color = UnknownVarFromTrophyView_ITrophyFurniWidget_1.headerColor;
         }
         _loc11_ = _window.findChildByName("title") as ITextWindow;
         if(_loc11_ != null)
         {
            _loc11_.text = UnknownVarFromTrophyView_ITrophyFurniWidget_1.frameTitle;
         }
         _loc6_ = _window.findChildByName("greeting") as ITextWindow;
         if(_loc6_ != null)
         {
            _loc6_.text = UnknownVarFromTrophyView_ITrophyFurniWidget_1.message.replace(/\\r/g,"\n");
         }
         _loc3_ = _window.findChildByName("date") as ITextWindow;
         if(_loc3_ != null)
         {
            _loc3_.text = UnknownVarFromTrophyView_ITrophyFurniWidget_1.date;
         }
         _loc7_ = _window.findChildByName("name") as ITextWindow;
         if(_loc7_ != null)
         {
            _loc7_.text = UnknownVarFromTrophyView_ITrophyFurniWidget_1.name;
         }
         _loc5_ = UnknownVarFromTrophyView_ITrophyFurniWidget_1.assets.getAssetByName(TrophyTheme.getBackgroundAssetName(UnknownVarFromTrophyView_ITrophyFurniWidget_1.backgroundTheme)) as BitmapDataAsset;
         _loc8_ = _window.findChildByName("trophy_bg") as IBitmapWrapperController;
         if(_loc8_ != null)
         {
            _loc8_.color = uint(UnknownVarFromTrophyView_ITrophyFurniWidget_1.color);
         }
         if(_loc5_ != null && _loc8_ != null)
         {
            _loc4_ = _loc5_.content as BitmapData;
            _loc8_.bitmap = _loc4_;
         }
         return true;
      }
      
      public function disposeInterface() : void
      {
         if(_window != null)
         {
            _window.dispose();
            _window = null;
         }
      }
      
      private function onMouseEvent(param1:WindowMouseEvent) : void
      {
         disposeInterface();
      }
   }
}

