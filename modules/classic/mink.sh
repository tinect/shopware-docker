#!/usr/bin/env bash

cd /var/www/html/$SHOPWARE_PROJECT

php ${DIR}/modules/classic/fix-config.php "$SHOPWARE_FOLDER/config.php" csrf

echo "default:
    extensions:
        SensioLabs\Behat\PageObjectExtension:
            namespaces:
                page: Shopware\Tests\Mink\Page
                element: Shopware\Tests\Mink\Element
        Shopware\Behat\ShopwareExtension: ~
        Behat\MinkExtension:
            ## defined in buildscript
            base_url: 'http://$SHOPWARE_PROJECT.dev.localhost.lm.local'
            default_session: 'goutte'
            javascript_session: 'selenium2'
            goutte: ~
            browser_name: chrome
            selenium2:
                wd_host: "http://selenium:4444/wd/hub"
                capabilities:
                    chrome:
                        switches:
                            - "--disable-gpu"
                            - "--headless"
                            - "--no-sandbox"

    gherkin:
      filters:
        tags: ~@knownFailing

    suites:
        default:
            paths:    [ %paths.base%/features ]
            template: Responsive
            contexts:
                - Behat\MinkExtension\Context\MinkContext
                - Shopware\Tests\Mink\FeatureContext
                - Shopware\Tests\Mink\BackendContext
                - Shopware\Tests\Mink\AccountContext
                - Shopware\Tests\Mink\BlogContext
                - Shopware\Tests\Mink\CheckoutContext
                - Shopware\Tests\Mink\DetailContext
                - Shopware\Tests\Mink\FormContext
                - Shopware\Tests\Mink\ListingContext
                - Shopware\Tests\Mink\NoteContext
                - Shopware\Tests\Mink\SeoContext
                - Shopware\Tests\Mink\ShopwareContext
                - Shopware\Tests\Mink\SitemapContext
                - Shopware\Tests\Mink\SpecialContext
                - Shopware\Tests\Mink\TransformContext
                - Shopware\Tests\Mink\SecurityContext
                - Shopware\Tests\Mink\ExportContext" > tests/Mink/behat.yml

vendor/bin/behat -vv --config=tests/Mink/behat.yml --format=pretty --out=std --format=junit --out=build/artifacts/mink ${@:3}