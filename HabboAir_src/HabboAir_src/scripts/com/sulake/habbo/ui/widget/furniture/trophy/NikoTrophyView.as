package com.sulake.habbo.ui.widget.furniture.trophy
{
   import com.sulake.core.assets.ISoundAsset;
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IRegionWindow;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.components.ITextLinkWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.utils.HabboWebTools;
   
   public class NikoTrophyView implements ITrophyView
   {
      private var UnknownVarFromNikoTrophyView_Int_1:int;
      
      private var UnknownVarFromNikoTrophyView_TrophyFurniWidget_1:TrophyFurniWidget;
      
      private var _window:IWindowController_1;
      
      public function NikoTrophyView(param1:TrophyFurniWidget, param2:int)
      {
         super();
         UnknownVarFromNikoTrophyView_TrophyFurniWidget_1 = param1;
         UnknownVarFromNikoTrophyView_Int_1 = param2;
      }
      
      public function dispose() : void
      {
         if(_window)
         {
            _window.dispose();
            _window = null;
         }
         UnknownVarFromNikoTrophyView_TrophyFurniWidget_1 = null;
      }
      
      public function showInterface() : Boolean
      {
         var _loc2_:IWindowModel = null;
         var _loc4_:ITextWindow = null;
         var _loc6_:ITextLinkWindow = null;
         var _loc3_:ITextWindow = null;
         var _loc7_:IStaticBitmapWrapperWindow = null;
         var _loc5_:* = null;
         var _loc8_:ISoundAsset = UnknownVarFromNikoTrophyView_TrophyFurniWidget_1.assets.getAssetByName("niko_trophy");
         var _loc1_:XmlAsset = XmlAsset(_loc8_);
         if(_loc1_ == null)
         {
            return false;
         }
         if(_window == null)
         {
            _window = UnknownVarFromNikoTrophyView_TrophyFurniWidget_1.windowManager.buildFromXML(_loc1_.content as XML) as IWindowController_1;
         }
         _window.center();
         _loc2_ = _window.findChildByName("header_button_close");
         if(_loc2_ != null)
         {
            _loc2_.addEventListener("WME_CLICK",onCloseElem);
         }
         _loc4_ = _window.findChildByName("html_textbox") as ITextWindow;
         if(_loc4_ != null)
         {
            switch(UnknownVarFromNikoTrophyView_Int_1 - 10)
            {
               case 0:
                  _loc4_.text = UnknownVarFromNikoTrophyView_TrophyFurniWidget_1.localizations.getLocalization("niko.trophy.description.silver");
                  break;
               case 10:
                  _loc4_.text = UnknownVarFromNikoTrophyView_TrophyFurniWidget_1.localizations.getLocalization("niko.trophy.description.gold");
            }
         }
         _loc6_ = _window.findChildByName("store_link") as ITextLinkWindow;
         if(_loc6_ != null)
         {
            _loc6_.addEventListener("WME_CLICK",onAppstoreLink);
         }
         _loc3_ = _window.findChildByName("date") as ITextWindow;
         if(_loc3_ != null)
         {
            UnknownVarFromNikoTrophyView_TrophyFurniWidget_1.localizations.registerParameter("trophy.niko.date","date",UnknownVarFromNikoTrophyView_TrophyFurniWidget_1.date);
            _loc3_.text = UnknownVarFromNikoTrophyView_TrophyFurniWidget_1.localizations.getLocalization("trophy.niko.date");
         }
         _loc7_ = _window.findChildByName("preview_image") as IStaticBitmapWrapperWindow;
         if(_loc7_ != null)
         {
            if(UnknownVarFromNikoTrophyView_Int_1 == 20)
            {
               _loc7_.assetUri = "${image.library.url}niko/niko_trophy_gold.png";
            }
            else
            {
               _loc7_.assetUri = "${image.library.url}niko/niko_trophy_silver.png";
            }
         }
         _loc7_ = _window.findChildByName("store_image") as IStaticBitmapWrapperWindow;
         if(_loc7_ != null)
         {
            _loc7_.assetUri = "${image.library.url}niko/" + UnknownVarFromNikoTrophyView_TrophyFurniWidget_1.configuration.getProperty("niko.trophy.appstore.image") + ".png";
         }
         var _loc9_:IRegionWindow = _window.findChildByName("appstore_region") as IRegionWindow;
         if(_loc9_)
         {
            _loc9_.addEventListener("WME_CLICK",onAppstoreLink);
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
      
      private function onAppstoreLink(param1:WindowMouseEvent) : void
      {
         var _loc2_:String = UnknownVarFromNikoTrophyView_TrophyFurniWidget_1.configuration.getProperty("niko.appstore.link.url");
         HabboWebTools.openWebPage(_loc2_,"habboMain");
      }
      
      private function onCloseElem(param1:WindowMouseEvent) : void
      {
         disposeInterface();
      }
   }
}

