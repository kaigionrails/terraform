resource "cloudflare_zone" "kaigionrails_org" {
  # zone_id: "13373bcb6ae8d714dc8b48e6204df945"
  account_id = var.cloudflare_account_id
  zone       = "kaigionrails.org"
}

resource "cloudflare_record" "upload_2022" {
  zone_id = cloudflare_zone.kaigionrails_org.id
  name    = "upload-2022"
  type    = "A"
  value   = "199.36.158.100"
  ttl     = 300
}

resource "cloudflare_record" "cname_2021" {
  zone_id = cloudflare_zone.kaigionrails_org.id
  name    = "2021"
  type    = "CNAME"
  value   = "ruby-no-kai.github.io"
  ttl     = 1
}

resource "cloudflare_record" "cname_2022" {
  zone_id = cloudflare_zone.kaigionrails_org.id
  name    = "2022"
  type    = "CNAME"
  value   = "kaigionrails.github.io"
  ttl     = 1
}

resource "cloudflare_record" "cname_2023" {
  zone_id = cloudflare_zone.kaigionrails_org.id
  name    = "2023"
  type    = "CNAME"
  value   = "kaigionrails.github.io"
  ttl     = 300
}

resource "cloudflare_record" "cname_2024" {
  zone_id = cloudflare_zone.kaigionrails_org.id
  name    = "2024"
  type    = "CNAME"
  value   = "kaigionrails.github.io"
  ttl     = 300
}

resource "cloudflare_record" "google_verify" {
  zone_id = cloudflare_zone.kaigionrails_org.id
  name    = "22161183"
  type    = "CNAME"
  value   = "case-22161183-for-kaigionrails.org-at.google.com"
  ttl     = 1
}

## conference app
resource "cloudflare_record" "conference_app_production" {
  zone_id = cloudflare_zone.kaigionrails_org.id
  name    = "app"
  type    = "CNAME"
  value   = "an5i3pv4yg.us-west-2.awsapprunner.com"
  ttl     = 1
  proxied = true
}

resource "cloudflare_record" "conference_app_cert_valid_1" {
  zone_id = cloudflare_zone.kaigionrails_org.id
  name    = "_72e72ca487543b43f54be4e6c49247d2.app"
  type    = "CNAME"
  value   = "_4fd9b2812b4c1554aed67b4a5e59ae32.sdgjtdhdhz.acm-validations.aws."
  ttl     = 3600
  comment = "For domain validation by AWS"
}

resource "cloudflare_record" "conference_app_cert_valid_2" {
  zone_id = cloudflare_zone.kaigionrails_org.id
  name    = "_bdc1563341fb0347f4bbf4c26a60ca67.www.app"
  type    = "CNAME"
  value   = "_e06c70a7b05558bb348a25013aa21119.sdgjtdhdhz.acm-validations.aws."
  ttl     = 3600
  comment = "For domain validation by AWS"
}

resource "cloudflare_record" "conference_app_cert_valid_3" {
  zone_id = cloudflare_zone.kaigionrails_org.id
  name    = "_d6b85c8010b53f60c92bb88d424d7af2.2a57j77vgoemr8puv5ikbogcmcui9fd.app"
  type    = "CNAME"
  value   = "_7961062668e4d2d18b0b8e023b7eb14b.sdgjtdhdhz.acm-validations.aws."
  ttl     = 3600
  comment = "For domain validation by AWS"
}
## end conference app

resource "cloudflare_record" "conference_app_staging" {
  zone_id = cloudflare_zone.kaigionrails_org.id
  name    = "conf-app-staging"
  type    = "CNAME"
  value   = "angular-peony-qjzx6tubtntybgs9z7y0ou8j.herokudns.com"
  ttl     = 1
  proxied = true
}

resource "cloudflare_record" "cfp_app" {
  zone_id = cloudflare_zone.kaigionrails_org.id
  name    = "cfp"
  type    = "CNAME"
  value   = "qt3zbts8fe.us-west-2.awsapprunner.com"
  ttl     = 1
}

resource "cloudflare_record" "cfp_app_cert_valid_1" {
  zone_id = cloudflare_zone.kaigionrails_org.id
  name    = "_dd32d11fedb954e6e4cc9415bebd3e7e.cfp"
  type    = "CNAME"
  value   = "_3c18da2155d59ba16c7ad38d510659f8.sdgjtdhdhz.acm-validations.aws."
  ttl     = 3600
  comment = "For domain validation by AWS"
}

resource "cloudflare_record" "cfp_app_cert_valid_2" {
  zone_id = cloudflare_zone.kaigionrails_org.id
  name    = "_22d9373d5a624fa20ef7e95c7002f054.2a57j78d05nkylnjxxxbsfyb1hqpih3.cfp"
  type    = "CNAME"
  value   = "_597ba04efb7103226f09e0cadac39ebc.sdgjtdhdhz.acm-validations.aws."
  ttl     = 3600
  comment = "For domain validation by AWS"
}

resource "cloudflare_record" "cfp_app_cert_valid_3" {
  zone_id = cloudflare_zone.kaigionrails_org.id
  name    = "_84259321a368ac89024575c5164a6d03.www.cfp"
  type    = "CNAME"
  value   = "_642ac4dd88b62c4d8a01a858bc7cff76.sdgjtdhdhz.acm-validations.aws."
  ttl     = 3600
  comment = "For domain validation by AWS"
}

resource "cloudflare_record" "past" {
  zone_id = cloudflare_zone.kaigionrails_org.id
  name    = "past"
  type    = "CNAME"
  value   = "ruby-no-kai.github.io"
  ttl     = 1
}

resource "cloudflare_record" "sponsor_app" {
  zone_id = cloudflare_zone.kaigionrails_org.id
  name    = "sponsorships"
  type    = "CNAME"
  value   = "immense-lavender-3hnhgmcaijeqiw624c9zohet.herokudns.com"
  ttl     = 1
}

resource "cloudflare_record" "mx_google" {
  zone_id  = cloudflare_zone.kaigionrails_org.id
  name     = "kaigionrails.org"
  type     = "MX"
  value    = "aspmx.l.google.com"
  priority = 1
  ttl      = 1
}

resource "cloudflare_record" "mx_google_alt1" {
  zone_id  = cloudflare_zone.kaigionrails_org.id
  name     = "kaigionrails.org"
  type     = "MX"
  value    = "alt1.aspmx.l.google.com"
  priority = 5
  ttl      = 1
}

resource "cloudflare_record" "mx_google_alt2" {
  zone_id  = cloudflare_zone.kaigionrails_org.id
  name     = "kaigionrails.org"
  type     = "MX"
  value    = "alt2.aspmx.l.google.com"
  priority = 5
  ttl      = 1
}

resource "cloudflare_record" "mx_google_alt3" {
  zone_id  = cloudflare_zone.kaigionrails_org.id
  name     = "kaigionrails.org"
  type     = "MX"
  value    = "alt3.aspmx.l.google.com"
  priority = 10
  ttl      = 1
}

resource "cloudflare_record" "mx_google_alt4" {
  zone_id  = cloudflare_zone.kaigionrails_org.id
  name     = "kaigionrails.org"
  type     = "MX"
  value    = "alt4.aspmx.l.google.com"
  priority = 10
  ttl      = 1
}

resource "cloudflare_record" "mx_google_verify" {
  zone_id  = cloudflare_zone.kaigionrails_org.id
  name     = "kaigionrails.org"
  type     = "MX"
  value    = "3asytb3b63jfhxl6yijytjtcgxuftk5orfppfpuiaenyeyxratwa.mx-verification.google.com"
  priority = 15
  ttl      = 1
}

resource "cloudflare_record" "dmarc" {
  zone_id = cloudflare_zone.kaigionrails_org.id
  name    = "_dmarc"
  type    = "TXT"
  value   = "\"v=DMARC1;  p=quarantine; rua=mailto:7e4dd9191fff4ca58d43c9e4a7a67b40@dmarc-reports.cloudflare.net,mailto:dmarc@kaigionrails.org\""
  ttl     = 1
}

resource "cloudflare_record" "spf" {
  zone_id = cloudflare_zone.kaigionrails_org.id
  name    = "kaigionrails.org"
  type    = "TXT"
  value   = "v=spf1 include:mailgun.org include:_spf.google.com ~all"
  ttl     = 1
}

resource "cloudflare_record" "google_site_verifivation" {
  zone_id = cloudflare_zone.kaigionrails_org.id
  name    = "kaigionrails.org"
  type    = "TXT"
  value   = "google-site-verification=uhm3OiuP2yukFmkPKleF4l4hc_dmaMwxjJci2oYT2h0"
  ttl     = 1
}

resource "cloudflare_record" "dkim" {
  zone_id = cloudflare_zone.kaigionrails_org.id
  name    = "pic._domainkey"
  type    = "TXT"
  value   = "k=rsa; p=MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCusxsCqLjU5gP+3dwvYAb/gVns8zSJOtDE2EM4RF53TbpXfN5lQJ/PJnmmkONu4QQ38ZaU/JOZarpBG359dn6dT6KMzn07Lhlm88FCAGcuWmGcXemzHZewoOWtjcwXjtLXsMmyb2bEWHdsGWPSqYEg9aRLercMPQKGiQJBFaIz2QIDAQAB"
  ttl     = 1
}

# TODO: cannot import...
# resource "cloudflare_worker_domain" "kor_router" {
#   account_id = var.cloudflare_account_id
#   zone_id    = cloudflare_zone.kaigionrails_org.id
#   hostname   = "kaigionrails.org"
#   service    = "kor-router"
# }
