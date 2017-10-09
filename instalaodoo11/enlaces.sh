#!/bin/bash

if [ "$(id -u)" != "0" ]; then
   echo "La instalación debe hacerse como root" 1>&2
   exit 1
fi

source config.sh

RUTA=`pwd`

cd $ADDONS_DIR
ln -s ../server-tools/disable_odoo_online
ln -s ../partner-contact/base_location
ln -s ../partner-contact/base_location_geonames_import
ln -s ../account-invoicing/account_invoice_check_total
ln -s ../bank-payment/account_payment_mode
ln -s ../bank-payment/account_payment_partner
ln -s ../bank-payment/account_payment_sale
ln -s ../server-tools/admin_technical_features
ln -s ../server-tools/auth_admin_passkey
ln -s ../server-tools/base_export_manager
ln -s ../server-tools/base_search_fuzzy
ln -s ../server-tools/base_technical_features
ln -s ../server-tools/base_user_role
ln -s ../contract/contract
ln -s ../contract/contract_show_invoice
ln -s ../server-tools/date_range
ln -s ../addons-difusioncloud/document_url
ln -s ../addons-jayvora-massediting/mass_editing
ln -s ../server-tools/mass_sorting
ln -s ../addons-xubiuit-weblogin/odoo_web_login
ln -s ../project-service/project_description
ln -s ../project-service/project_model_to_task
ln -s ../project-service/project_stage_state
ln -s ../project-service/project_task_add_very_high
ln -s ../project-service/project_task_code
ln -s ../project-service/project_task_default_stage
ln -s ../project-service/project_task_dependency
ln -s ../sale-workflow/sale_product_set
ln -s ../sale-workflow/sale_product_set_layout
ln -s ../web/web_responsive
ln -s ../web/web_sheet_full_width
ln -s ../account-financial-tools/account_chart_update
ln -s ../account-payment/account_due_list
ln -s ../reporting-engine/report_xls
ln -s ../account-financial-tools/account_renumber
ln -s ../web/web_shortcuts/
ln -s ../web/web_tree_many2one_clickable
ln -s ../partner-contact/res_partner_affiliate
ln -s ../account-financial-tools/account_invoice_currency
ln -s ../server-tools/auto_backup
