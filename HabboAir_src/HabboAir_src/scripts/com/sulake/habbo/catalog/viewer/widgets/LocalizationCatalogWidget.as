package com.sulake.habbo.catalog.viewer.widgets
{
   import com.sulake.core.assets.AssetLoaderStruct;
   import com.sulake.core.assets.BitmapDataAsset;
   import com.sulake.core.assets.loaders.AssetLoaderEvent;
   import com.sulake.core.runtime.IComponent_1;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IBitmapWrapperController;
   import com.sulake.core.window.components.IHTMLTextController;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.events.WindowLinkEvent;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.core.window.utils.UnknownICoreWindowUtils1;
   import com.sulake.habbo.catalog.HabboCatalog;
   import com.sulake.habbo.catalog.navigation.ICatalogNavigator;
   import com.sulake.habbo.catalog.navigation.ICatalogNode;
   import com.sulake.habbo.catalog.viewer.widgets.events.SelectProductEvent;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   import com.sulake.habbo.utils.HabboWebTools;
   import flash.display.BitmapData;
   import flash.geom.Point;
   import flash.net.URLRequest;
   import flash.text.StyleSheet;
   import flash.utils.Dictionary;
   
   public class LocalizationCatalogWidget extends CatalogWidget implements ICatalogWidget
   {
      private var UnknownVarFromLocalizationCatalogWidget_Dictionary_1:Dictionary;
      
      private var _catalog:HabboCatalog;
      
      public function LocalizationCatalogWidget(param1:IWindowController_1, param2:HabboCatalog)
      {
         super(param1);
         UnknownVarFromLocalizationCatalogWidget_Dictionary_1 = new Dictionary();
         _catalog = param2;
      }
      
      override public function dispose() : void
      {
         super.dispose();
         _catalog = null;
      }
      
      override public function init() : Boolean
      {
         if(!super.init())
         {
            return false;
         }
         initLocalizables();
         initStaticImages();
         initLinks();
         events.addEventListener("SELECT_PRODUCT",onProductSelected);
         return true;
      }
      
      private function onProductSelected(param1:SelectProductEvent) : void
      {
         if(param1 == null)
         {
            return;
         }
      }
      
      private function initLinks() : void
      {
         var _loc2_:IWindowModel = null;
         if(page.hasLinks)
         {
            for each(var _loc1_ in page.links)
            {
               _loc2_ = _window.findChildByName(_loc1_);
               if(_loc2_ != null)
               {
                  _loc2_.setParamFlag(1);
                  _loc2_.mouseThreshold = 0;
                  _loc2_.addEventListener("WME_CLICK",onClickLink);
               }
            }
         }
      }
      
      private function onClickLink(param1:WindowMouseEvent) : void
      {
         var _loc3_:* = null;
         var _loc4_:IHabboLocalizationManager = (page.viewer.catalog as HabboCatalog).localization;
         var _loc2_:IComponent_1 = page.viewer.catalog as HabboCatalog;
         var _loc6_:String = IWindowModel(param1.target).name;
         var _loc5_:String = "";
         switch(page.layoutCode)
         {
            case "frontpage3":
               switch(_loc6_)
               {
                  case "ctlg_txt3":
                     if(IWindowModel(param1.target).caption != "")
                     {
                        _loc5_ = page.localization.getTextElementContent(6);
                        page.viewer.catalog.openCatalogPage(_loc5_);
                     }
                     break;
                  case "ctlg_txt7":
                     if(IWindowModel(param1.target).caption != "")
                     {
                        _loc5_ = page.localization.getTextElementContent(10);
                        if(_loc5_.indexOf("http") >= 0)
                        {
                           openExternalLink(_loc5_);
                        }
                        else if(_loc5_ == "credits")
                        {
                           HabboWebTools.openWebPageAndMinimizeClient(_catalog.getProperty("web.shop.relativeUrl"));
                        }
                        else
                        {
                           page.viewer.catalog.openCatalogPage(_loc5_);
                        }
                     }
               }
               break;
            case "info_pixels":
               switch(_loc6_)
               {
                  case "ctlg_text_5":
                     _catalog.questEngine.showAchievements();
                     break;
                  case "ctlg_text_7":
                     _loc5_ = page.localization.getTextElementContent(7);
                     page.viewer.catalog.openCatalogPage(_loc5_);
               }
               break;
            case "info_credits":
               switch(_loc6_)
               {
                  case "ctlg_text_5":
                     HabboWebTools.openWebPageAndMinimizeClient(_catalog.getProperty("web.shop.relativeUrl"));
                     break;
                  case "ctlg_text_7":
                     _loc5_ = page.localization.getTextElementContent(7);
                     page.viewer.catalog.openCatalogPage(_loc5_);
               }
               break;
            case "collectibles":
               var _loc7_:* = _loc6_;
               if("ctlg_collectibles_link" === _loc7_)
               {
                  _loc5_ = _loc2_.getProperty("link.format.collectibles");
                  openExternalLink(_loc5_);
               }
               break;
            case "club1":
               _loc7_ = _loc6_;
               if("ctlg_text_5" === _loc7_)
               {
                  page.viewer.catalog.openCatalogPage("hc_membership");
               }
               break;
            case "club_buy":
               _loc7_ = _loc6_;
               if("club_link" === _loc7_)
               {
                  _loc5_ = _loc2_.getProperty("link.format.club");
                  openExternalLink(_loc5_);
               }
               break;
            case "mad_money":
               _loc7_ = _loc6_;
               if("ctlg_madmoney_button" === _loc7_)
               {
                  _loc5_ = _loc2_.getProperty("link.format.madmoney");
                  openExternalLink(_loc5_);
               }
               break;
            case "monkey":
               switch(_loc6_)
               {
                  case "ctlg_teaserimg_1_region":
                  case "ctlg_special_img_region":
                     _loc5_ = _loc4_.getLocalization("link.format.monkey","http://store.apple.com/");
                     openExternalLink(_loc5_);
               }
               break;
            case "niko":
               switch(_loc6_)
               {
                  case "ctlg_teaserimg_1_region":
                  case "ctlg_special_img_region":
                     _loc5_ = _loc4_.getLocalization("link.format.niko","http://itunes.apple.com/us/app/niko/id481670205?mt=8");
                     openExternalLink(_loc5_);
               }
               break;
            default:
               Logger.log("[Localization Catalog Widget] Unhandled link clicked" + [page.layoutCode,_loc6_]);
         }
      }
      
      private function openExternalLink(param1:String) : void
      {
         if(param1 != "")
         {
            page.viewer.catalog.windowManager.alert("${catalog.alert.external.link.title}","${catalog.alert.external.link.desc}",0,onExternalLink);
            HabboWebTools.navigateToURL(param1,"habboMain");
         }
      }
      
      private function onExternalLink(param1:UnknownICoreWindowUtils1, param2:WindowEvent) : void
      {
         param1.dispose();
      }
      
      private function initStaticImages() : void
      {
         var _loc4_:String = null;
         var _loc2_:String = null;
         var _loc1_:Array = [];
         _window.groupChildrenWithTag("STATIC_IMAGE",_loc1_,10);
         for each(var _loc3_ in _loc1_)
         {
            if(_loc3_ is IBitmapWrapperController)
            {
               _loc4_ = _loc3_.name;
               _loc2_ = _loc3_.name;
               UnknownVarFromLocalizationCatalogWidget_Dictionary_1[_loc2_] = _loc4_;
               if(page.viewer.catalog.assets.hasAsset(_loc2_))
               {
                  setElementImage(_loc4_,_loc2_);
               }
               else
               {
                  retrieveCatalogImage(_loc2_);
               }
            }
         }
      }
      
      protected function initLocalizables() : void
      {
         var _loc10_:String = null;
         var _loc7_:String = null;
         var _loc9_:IWindowModel = null;
         var _loc2_:* = null;
         var _loc6_:* = null;
         var _loc5_:int = 0;
         UnknownVarFromLocalizationCatalogWidget_Dictionary_1 = new Dictionary();
         page.viewer.mainContainer.findChildByName("catalog.header.description").caption = "";
         _loc5_ = 0;
         while(_loc5_ < page.localization.textCount)
         {
            _loc10_ = page.localization.getTextElementName(_loc5_,page.layoutCode);
            _loc7_ = page.localization.getTextElementContent(_loc5_);
            if(_loc10_ == "catalog.header.description")
            {
               _loc9_ = page.viewer.mainContainer.findChildByName(_loc10_);
            }
            else if(_window != null)
            {
               _loc9_ = _window.findChildByName(_loc10_);
            }
            if(_loc9_ != null)
            {
               _loc7_ = _loc7_.replace(/\r\n/g,"\n");
               _loc9_.caption = _loc7_;
               if(_loc9_ is IHTMLTextController)
               {
                  _loc9_.addEventListener("WE_LINK",onClickHtmlLink);
                  setLinkStyle(_loc9_ as IHTMLTextController);
               }
            }
            else
            {
               Logger.log("[Localization Catalog Widget] Could not place text in layout:  element: " + _loc10_ + ", content: " + _loc7_);
            }
            _loc5_++;
         }
         _loc5_ = 0;
         while(_loc5_ < page.localization.imageCount)
         {
            _loc10_ = page.localization.getImageElementName(_loc5_,page.layoutCode);
            _loc7_ = page.localization.getImageElementContent(_loc5_);
            if(_loc10_ != "")
            {
               if(_loc7_ != "")
               {
                  _loc6_ = _loc7_;
                  UnknownVarFromLocalizationCatalogWidget_Dictionary_1[_loc6_] = _loc10_;
                  if(page.viewer.catalog.assets.hasAsset(_loc6_))
                  {
                     setElementImage(_loc10_,_loc6_);
                  }
                  else
                  {
                     retrieveCatalogImage(_loc6_);
                  }
               }
            }
            _loc5_++;
         }
         var _loc3_:ICatalogNavigator = _catalog.getCatalogNavigator(page.viewer.catalogType);
         var _loc1_:ICatalogNode = _loc3_ == null ? null : _loc3_.getNodeById(page.pageId);
         var _loc8_:IWindowModel = page.viewer.mainContainer.findChildByName("catalog.header.title");
         var _loc4_:IStaticBitmapWrapperWindow = page.viewer.mainContainer.findChildByName("catalog.header.icon") as IStaticBitmapWrapperWindow;
         if(_loc8_ != null)
         {
            _loc8_.caption = _loc1_ != null ? _loc1_.localization : (page.mode == 1 ? "${catalog.search.header}" : "${catalog.header}");
         }
         if(_loc4_ != null && _loc1_ != null)
         {
            _loc4_.assetUri = page.mode == 1 ? "common_small_pen" : (page.isBuilderPage ? _catalog.imageGalleryHost + "icon_193.png" : _catalog.imageGalleryHost + _loc1_.iconName + ".png");
         }
      }
      
      private function onClickHtmlLink(param1:WindowEvent) : void
      {
         var _loc2_:WindowLinkEvent = param1 as WindowLinkEvent;
         if(_loc2_ != null)
         {
            Logger.log("=============== HTML LINK: " + _loc2_.link);
         }
         else
         {
            Logger.log("=============== BAD HTML LINK: " + param1.target);
         }
      }
      
      private function setElementImage(param1:String, param2:String) : void
      {
         var _loc9_:IWindowModel = null;
         var _loc7_:BitmapDataAsset = null;
         var _loc4_:BitmapData = null;
         var _loc3_:int = 0;
         var _loc5_:int = 0;
         var _loc8_:String = null;
         var _loc6_:String = null;
         Logger.log("[Localization Catalog Widget] Set Element Image: " + [param1,param2]);
         if(_window == null)
         {
            Logger.log("[Localization Catalog Widget] Window is null! " + [param1,param2]);
            return;
         }
         if(_window.disposed)
         {
            Logger.log("[Localization Catalog Widget] Window is disposed! " + [param1,param2,_window.name]);
            return;
         }
         if(param1 == "catalog.header.image")
         {
            _loc9_ = page.viewer.mainContainer.findChildByName(param1);
         }
         else
         {
            _loc9_ = _window.findChildByName(param1);
         }
         if(_loc9_ is IBitmapWrapperController)
         {
            _loc7_ = page.viewer.catalog.assets.getAssetByName(param2) as BitmapDataAsset;
            if(_loc7_ == null)
            {
               Logger.log("[Localization Catalog Widget] Asset does not exist (Bitmap window): " + [param1,param2]);
               return;
            }
            _loc4_ = _loc7_.content as BitmapData;
            if((_loc9_ as IBitmapWrapperController).bitmap == null)
            {
               (_loc9_ as IBitmapWrapperController).bitmap = new BitmapData(_loc9_.width,_loc9_.height,true,16777215);
            }
            (_loc9_ as IBitmapWrapperController).bitmap.fillRect((_loc9_ as IBitmapWrapperController).bitmap.rect,16777215);
            _loc3_ = (_loc9_.width - _loc4_.width) / 2;
            _loc5_ = (_loc9_.height - _loc4_.height) / 2;
            (_loc9_ as IBitmapWrapperController).bitmap.copyPixels(_loc4_,_loc4_.rect,new Point(_loc3_,_loc5_),null,null,true);
         }
         else if(_loc9_ is IStaticBitmapWrapperWindow)
         {
            _loc8_ = _catalog.getProperty("image.library.catalogue.url");
            _loc6_ = _loc8_ + param2 + ".gif";
            Logger.log("[Localization Catalog Widget] Static Image: " + _loc6_);
            (_loc9_ as IStaticBitmapWrapperWindow).assetUri = _loc6_;
         }
         else
         {
            Logger.log("[Localization Catalog Widget] Could not find element: " + param1);
         }
      }
      
      private function retrieveCatalogImage(param1:String) : void
      {
         var _loc5_:* = null;
         var _loc9_:IWindowModel = null;
         var _loc6_:String = (page.viewer.catalog as HabboCatalog).getProperty("image.library.catalogue.url");
         var _loc2_:String = (page.viewer.catalog as HabboCatalog).getProperty("image.library.url") + "Top_Story_Images/";
         var _loc8_:String = UnknownVarFromLocalizationCatalogWidget_Dictionary_1[param1];
         if(_loc8_ == "catalog.header.image")
         {
            _loc9_ = page.viewer.mainContainer.findChildByName(_loc8_);
         }
         else
         {
            _loc9_ = _window.findChildByName(_loc8_);
         }
         if(_loc9_ && _loc9_.tags.indexOf("TOP_STORY") > -1)
         {
            _loc5_ = _loc2_;
         }
         else
         {
            _loc5_ = _loc6_;
         }
         var _loc7_:String = _loc5_ + param1 + ".gif";
         Logger.log("[Localization Catalog Widget]  : " + _loc7_);
         var _loc3_:URLRequest = new URLRequest(_loc7_);
         var _loc4_:AssetLoaderStruct = page.viewer.catalog.assets.loadAssetFromFile(param1,_loc3_,"image/gif");
         _loc4_.addEventListener("AssetLoaderEventComplete",onCatalogImageReady);
      }
      
      private function onCatalogImageReady(param1:AssetLoaderEvent) : void
      {
         var _loc2_:String = null;
         var _loc4_:String = null;
         var _loc3_:AssetLoaderStruct = param1.target as AssetLoaderStruct;
         if(_loc3_ != null)
         {
            _loc2_ = _loc3_.assetName;
            _loc4_ = UnknownVarFromLocalizationCatalogWidget_Dictionary_1[_loc2_];
            setElementImage(_loc4_,_loc2_);
         }
      }
      
      private function setLinkStyle(param1:ITextWindow) : void
      {
         if(!param1)
         {
            return;
         }
         var _loc6_:StyleSheet = new StyleSheet();
         var _loc2_:Object = {};
         _loc2_.color = "#336a95";
         var _loc3_:Object = {};
         _loc3_.textDecoration = "underline";
         _loc3_.color = "#333333";
         var _loc5_:Object = {};
         _loc5_.color = "#41b7d9";
         var _loc4_:Object = {};
         _loc4_.textDecoration = "underline";
         _loc6_.setStyle("a:link",_loc3_);
         _loc6_.setStyle("a:hover",_loc2_);
         _loc6_.setStyle("a:active",_loc5_);
         _loc6_.setStyle(".visited",_loc4_);
         param1.styleSheet = _loc6_;
      }
   }
}

